#!/bin/bash

# ============================================================================
# 01-bootstrap-host.sh
# Initial Proxmox Host Setup Script
# Author: marcmontecalvo
# ============================================================================
# - Set hostname
# - Update packages
# - Install base tools (git, curl)
# - Clone homelab GitHub repo
# ============================================================================

set -e

# --- 1. Prompt for Hostname ---
echo "🛠  Enter hostname for this Proxmox server:"
read -rp "Hostname: " HOSTNAME

if [ -n "$HOSTNAME" ]; then
    echo "[INFO] Setting hostname to '$HOSTNAME'..."
    hostnamectl set-hostname "$HOSTNAME"
else
    echo "[WARN] No hostname entered. Skipping hostname configuration."
fi

# --- 2. Update the system ---
echo "📦 Updating Proxmox packages..."
apt update && apt full-upgrade -y

# --- 3. Install useful base packages ---
echo "📦 Installing base CLI tools..."
apt install -y curl wget git htop vim ifupdown2

# --- 4. Final Message ---
echo "✅ Basic Proxmox bootstrap complete."
echo "➡️  Next: run '02-iso-downloads.sh' to fetch ISO files for your homelab VMs."
