provider "aws" {
  region = "us-east-1"
}

# --- THE USER ONLY EDITS THESE TWO ---
variable "key_name" {
  default = "their-aws-ssh-key-name"
}

variable "github_runner_token" {
  default = "PASTE_TOKEN_FROM_GITHUB_SETTINGS_HERE"
}
# -------------------------------------

resource "aws_security_group" "app_sg" {
  name = "devops-assessment-sg"
  # Only Port 80 is needed for the app
  ingress { from_port = 80; to_port = 80; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  # Port 22 for their SSH access
  ingress { from_port = 22; to_port = 22; protocol = "tcp"; cidr_blocks = ["0.0.0.0/0"] }
  egress  { from_port = 0; to_port = 0; protocol = "-1"; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_instance" "app_server" {
  ami           = "ami-0e2c8ccd9e036d13a" 
  instance_type = "t2.micro"
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # 1. Install Docker & Compose
              sudo apt update
              sudo apt install -y docker.io docker-compose
              sudo usermod -aG docker ubuntu

              # 2. Setup GitHub Runner
              mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner
              curl -o actions-runner-linux-x64-2.311.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz
              tar xzf ./actions-runner-linux-x64-2.311.0.tar.gz
              
              # 3. Register the runner (Replace with YOUR repo URL)
              sudo -u ubuntu ./config.sh --url https://github.com/akshata14/devops-project --token ${var.github_runner_token} --name "EC2-Runner" --unattended --replace
              
              # 4. Start the runner service
              sudo ./svc.sh install
              sudo ./svc.sh start
              EOF
}

output "APP_URL" {
  value = "http://${aws_instance.app_server.public_ip}"
}
