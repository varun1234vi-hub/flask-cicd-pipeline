#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get upgrade -y

# Install Docker
apt-get install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Install AWS CLI + jq
apt-get install -y unzip curl jq
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip && ./aws/install

# Install CloudWatch agent
wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
dpkg -i amazon-cloudwatch-agent.deb

# Fetch DockerHub credentials from Secrets Manager
creds=$(aws secretsmanager get-secret-value --secret-id flask-cicd/dockerhub --query SecretString --output text)
username=$(echo $creds | jq -r .username)
password=$(echo $creds | jq -r .password)

# Login to DockerHub
echo $password | docker login -u $username --password-stdin

# Run Flask app
docker pull $username/flask-cicd-pipeline:latest
docker run -d --name flask-app --restart unless-stopped -p 5000:5000 $username/flask-cicd-pipeline:latest

# Run Prometheus
docker run -d --name prometheus --restart unless-stopped -p 9090:9090 prom/prometheus

# Run Grafana
docker run -d --name grafana --restart unless-stopped -p 3000:3000 grafana/grafana

echo 'user_data setup complete' > /tmp/setup_done.txt

