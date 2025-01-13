#!/bin/bash

# Update package list and install unzip
apt-get update -y
apt-get install -y unzip

# Install Docker
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common


# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


# Add Docker repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null


# Update package list and install Docker
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io


# Enable Docker service
systemctl enable docker
systemctl start docker


# Allow the 'ubuntu' user to run Docker without sudo
usermod -aG docker ubuntu


# Notify that the setup is complete
echo "Setup complete: unzip and Docker installed. Docker is accessible without sudo."

# Install AWS CLI (Version 2)
# Download AWS CLI installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the installer
unzip awscliv2.zip

# Run the installer
sudo ./aws/install

# Verify AWS CLI installation
aws --version

# Notify that AWS CLI setup is complete
echo "AWS CLI installed and ready to use."