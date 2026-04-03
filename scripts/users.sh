#!/bin/bash

set -e

LOG_FILE="$HOME/linux-production-server/docs/users-setup.log"

log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "$LOG_FILE"
}

mkdir -p "$HOME/linux-production-server/docs"
touch "$LOG_FILE"

USERNAME="devopsadmin"

log "Starting user setup..."

if id "$USERNAME" >/dev/null 2>&1; then
  log "User $USERNAME already exists. Skipping creation."
else
  log "Creating user $USERNAME..."
  sudo adduser --disabled-password--gecos "" "USERNAME"
fi

if groups "$USERNAME" | grep -q '\bsudo\b';
then
  log "User $USERNAME is already in sudo group."
else
  log "Adding $USERNAME to sudo group..."
  sudo usermod -aG sudo "$USERNAME"
fi

log "User setup complete."
