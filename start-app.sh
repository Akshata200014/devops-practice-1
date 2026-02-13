#!/bin/bash

# Fetch the current Public IP
PUBLIC_IP=$(curl -s http://checkip.amazonaws.com)

# Write it to a .env file
echo "PUBLIC_IP=$PUBLIC_IP" > .env
echo "VITE_API_URL=http://$PUBLIC_IP:8000" >> .env

# Run docker-compose using these variables
docker-compose up --build -d
