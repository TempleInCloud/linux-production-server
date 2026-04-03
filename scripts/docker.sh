#!/bin/bash

set -e

LOG_FILE="$HOME/linux-production-server/docs/docker-setup.log"

log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

mkdir -p "$HOME/linux-production-server/docs"
touch "$LOG_FILE"

log "Starting Docker setup..."

log "Removing old Docker versions if any..."
sudo apt remove -y docker docker-engine docker.io containerd runc 2>&1 | tee -a "$LOG_FILE"

log "Installing dependencies..."
sudo apt update -y 2>&1 | tee -a "$LOG_FILE"
sudo apt install -y ca-certificates curl gnupg 2>&1 | tee -a "$LOG_FILE"

log "Adding Docker GPG key..."
sudo mkdir -p /etc/apt/keystrings
sudo chmod 755 /etc/apt/keystrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keystrings/docker.gpg

log "Setting up Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keystrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

log "Installing Docker Engine..."
sudo apt update -y 2>&1 | tee -a "$LOG_FILE"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>&1 | tee -a "LOG_FILE"

log "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

log "Adding user to dicker group..."
sudo usermod -aG docker "$USER"

log "Docker setup complete." 
