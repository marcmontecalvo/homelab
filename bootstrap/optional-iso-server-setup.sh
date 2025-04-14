#!/bin/bash

# ============================================================================
# optional-iso-server-setup.sh
# Simple Docker-based HTTP server to host ISOs from your Proxmox environment
# Author: marcmontecalvo
# ============================================================================

# --- Variables ---
ISO_DIR="/var/lib/vz/template/iso"
CONTAINER_NAME="iso-server"
PORT=8080

# --- Create ISO directory if it doesn't exist ---
mkdir -p "$ISO_DIR"

# --- Start a lightweight Docker HTTP server ---
echo "🚀 Starting ISO server container..."
docker run -d \
  --name "$CONTAINER_NAME" \
  -p $PORT:80 \
  -v "$ISO_DIR":/usr/share/nginx/html:ro \
  nginx:alpine

# --- Done ---
echo "✅ ISO server is live! Access it at: http://<your-proxmox-ip>:$PORT"
echo "💡 Place ISO files into $ISO_DIR to make them available over HTTP."