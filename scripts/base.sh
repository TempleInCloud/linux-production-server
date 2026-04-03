#!/bin/bash

set -e
LOG_FILE="$HOME/linux-production-server/docs/base-setup.log"

log() {
  local message="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" | tee -a "LOG_FILE"
}

log "Starting base system setup..."

log "Updating package lists..."
sudo apt update -y 2>&1 | tee -a "LOG_FILE"

log "Upgrading installed packages..."
sudo apt upgrade -y 2>&1 | tee -a "LOG_FILE"

log "Installing base tools..."
sudo apt install -y \
  curl \
  wget \
  git \
  vim \
  unzip \
  htop \
  net-tools \
  ca-certificates \
  gnupg \
  lsb-release 2>&1 | tee -a "$LOG_FILE"

log "Base system setup complete"

