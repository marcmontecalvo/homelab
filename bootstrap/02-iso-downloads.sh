#!/bin/bash

# ============================================================================
# 02-iso-downloads.sh
# Download and extract ISO files required for homelab VM deployments
# Author: marcmontecalvo
# ============================================================================

set -e

ISO_DIR="/var/lib/vz/template/iso"
mkdir -p "$ISO_DIR"
cd "$ISO_DIR"

# --- OPNsense 25.1 ---
OPNSENSE_URL="https://mirror.ams1.nl.leaseweb.net/opnsense/releases/25.1/OPNsense-25.1-dvd-amd64.iso.bz2"
OPNSENSE_ISO="OPNsense-25.1-dvd-amd64.iso"

if [ ! -f "$ISO_DIR/$OPNSENSE_ISO" ]; then
    echo "🔽 Downloading OPNsense 25.1..."
    curl -LO "$OPNSENSE_URL"
    echo "📦 Extracting ISO..."
    bunzip2 "${OPNSENSE_ISO}.bz2"
else
    echo "✅ OPNsense ISO already exists. Skipping."
fi

# --- Add more ISOs below as needed ---
# Example:
# UBUNTU_URL="https://..."
# curl -LO "$UBUNTU_URL"

# --- Summary ---
echo "✅ ISO downloads complete. Files stored in: $ISO_DIR"