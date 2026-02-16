# devops-practice-1

# Full-Stack DevOps Assessment: Containerization, CI/CD, and IaC

## Project Overview
This project is a containerized "Hello World" full-stack application consisting of a **Django REST API** and a **React (Vite/TypeScript)** frontend. The goal of this assessment was to implement industry-standard DevOps practices including secure containerization, automated CI/CD pipelines, and Infrastructure as Code (IaC).

## 🚀 Features
- **Multi-Stage Docker Builds:** Optimized images for both Frontend and Backend to minimize size and attack surface.
- **Security:** Applications run as **non-root users** within containers.
- **Reverse Proxy:** Nginx is used as a reverse proxy to serve the frontend and route `/api` requests to the backend on a single port (80).
- **CI/CD Pipeline:** Automated Build, Push (Docker Hub), and Deploy using **GitHub Actions**.
- **Infrastructure as Code:** Provisioning of AWS EC2 and Security Groups using **Terraform**.
- **Self-Hosted Runner:** The deployment job runs directly on the EC2 instance for secure, keyless deployment.

---

## 🏗 Architecture
1. **Frontend:** React (Port 80 via Nginx)
2. **Backend:** Django (Port 8000, proxied via Nginx)
3. **Registry:** Docker Hub (Public Images)
4. **Cloud:** AWS EC2 (Provisioned via Terraform)

---

## 🛠 Setup & Deployment (One-Click Instructions)

This project is designed to be completely portable. To deploy this infrastructure and application, follow these steps:

### 1. Prerequisites
- AWS Account with CLI credentials configured.
- A GitHub repository with this code.
- An existing AWS SSH Key Pair (.pem).

### 2. Provision Infrastructure (Terraform)
1. Navigate to the `terraform/` directory.
2. Open `main.tf` and update the following variables:
   - `key_name`: Your AWS SSH key name.
   - `github_runner_token`: Obtained from GitHub (Settings > Actions > Runners > New self-hosted runner).
3. Run the following:
   ```bash
   terraform init
   terraform apply -auto-approve
