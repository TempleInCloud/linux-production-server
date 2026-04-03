#!/bin/bash

set -e

LOG_FILE="$HOME/linux-production-server/docs/security-setup.log"

log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

mkdir -p "$HOME/linux-production-server/docs"
touch "$LOG_FILE"

SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP_CONFIG="/etc/ssh/sshd_config.bak"

log "Starting security setup..."

if [ ! -f "$BACKUP_CONFIG" ]; then
  log "Creating SSH config backup..."
  sudo cp "$SSH_CONFIG" "$BACKUP_CONFIG"
else
  log "SSH config backup already exists. Skipping backup."
fi

log "Applying SSH hardening settings..."

sudo sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin no/' "$SSH_CONFIG"
sudo sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication no/' "$SSH_CONFIG"
sudo sed -i 's/^#\?PubkeyAuthentication.*/PubkeyAuthentication yes/' "$SSH_CONFIG"

if ! grep -q '^PasswordAuthentication yes' "$SSH_CONFIG"; then
  echo 'PubkeyAuthentication yes' | sudo tee -a "$SSH_CONFIG"
fi

log "Restarting SSH service..."
sudo systemctl restart ssh 2>&1 | tee -a "LOG_FILE"

log "Allowing required firewall ports..."
sudo ufw allow OpenSSH 2>&1 | tee -a "$LOG_FILE"
sudo ufw allow 80 2>&1 | tee -a "$LOG_FILE"
sudo ufw allow 443 2>&1 | tee -a "$LOG_FILE"

log "Enabling firewall..."
sudo ufw --force enable 2>&1 | tee -a "$LOG_FILE"

log "Security setup complete."
