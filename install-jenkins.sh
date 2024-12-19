#!/bin/bash

echo "Stopping and disabling Jenkins service..."
sudo systemctl disable jenkins --now || echo "Jenkins service not found or already stopped."

echo "Removing Jenkins service files..."
sudo rm -f /etc/systemd/system/jenkins.service
sudo rm -rf /var/lib/jenkins /etc/jenkins /var/log/jenkins
sudo systemctl daemon-reload

echo "Checking and removing Jenkins user..."
if id jenkins &>/dev/null; then
    sudo deluser --remove-home jenkins
else
    echo "Jenkins user does not exist."
fi

echo "Cleaning up residual files..."
sudo apt autoremove -y
sudo apt purge jenkins -y || echo "Jenkins package is not installed."

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Reinstalling prerequisites..."
sudo apt install -y fontconfig openjdk-17-jre
java -version || { echo "Java installation failed!"; exit 1; }

echo "Adding Jenkins repository..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
if [ ! -f /usr/share/keyrings/jenkins-keyring.asc ]; then
    echo "Failed to download Jenkins keyring. Exiting."
    exit 1
fi

echo "Configuring Jenkins repository..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Installing Jenkins..."
sudo apt update
sudo apt install -y jenkins

echo "Starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager
