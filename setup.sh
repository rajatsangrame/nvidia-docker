#! /bin/bash

# Update the apt package index:
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

# Set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

# Install the latest version of Docker Engine - Community
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Check Installtion
sudo docker run hello-world


# Add Nvidia-Docker the package repositories
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

# Install Nvidia-Docker 
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit
sudo systemctl restart docker
sudo apt-get install nvidia-docker2
sudo pkill -SIGHUP dockerd

# check version
sudo docker version
sudo nvidia-docker version

echo ""
echo "Installation Complete"
echo ""
echo "To pull the container and start nvidia digits run"
echo "sudo docker run -d --runtime=nvidia --name=digits -p 5000:5000 -v <path_to_data> nvidia/digits"

