#!/bin/bash

LOG_FILE="$HOME/linux-production-server/docs/k3s-setup.log"

log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - message" | tee -a "$LOG_FILE"
}

mkdir -p "$HOME/linux-production-server/docs"
touch "$LOG_FILE"

log "Starting k3s setup..."

if command -v k3s >/dev/null 2>&1; then 
  log "k3s is already installed. Skipping installation."
else
  log "Installation k3s..."
  curl -sfl https://get.k3s.io | sh - 2>&1 | tee -a "$LOG_FILE"
fi

log "Checking k3s service status.."
sudo systemctl enable k3s 2>&1 | tee -a "$LOG_FILE"
sudo systemctl start k3s 2>&1 |tee -a "$LOG_FILE"

log "Waiting for node to become ready..."
sleep 10

log "Verifying cluster..."
sudo k3s kubectl get nodes -o wide 2>&1 | tee -a "$LOG_FILE"

log "k3s setup complete."
