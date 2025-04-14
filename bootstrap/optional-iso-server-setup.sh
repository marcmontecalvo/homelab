#!/bin/bash

# optional-iso-server-setup.sh
# Deploys a lightweight ISO server via Docker in an LXC container on VLAN40

# -----------------------------
# Configuration
# -----------------------------
TEMPLATE_ID="8001"
LXC_ID="200"
HOSTNAME="iso-server"
IP_ADDRESS="10.10.40.11"
GATEWAY="10.10.40.1"
NFS_EXPORT_PATH="/volume1/proxmox_iso_storage"
NFS_SERVER="10.10.10.6"
STORAGE="local-zfs"
BRIDGE="vmbr0"
TAG="40"
DNS_SERVER="10.10.40.1"

# -----------------------------
# Create Container from Template
# -----------------------------
echo "[*] Creating LXC container $LXC_ID ($HOSTNAME)..."

pct create $LXC_ID $TEMPLATE_ID \
  --hostname $HOSTNAME \
  --ostype debian \
  --memory 512 \
  --cores 1 \
  --net0 name=eth0,bridge=$BRIDGE,tag=$TAG,ip=$IP_ADDRESS/24,gw=$GATEWAY \
  --rootfs $STORAGE:4 \
  --nameserver $DNS_SERVER \
  --unprivileged 1 \
  --features nesting=1

# -----------------------------
# Start Container
# -----------------------------
echo "[*] Starting container..."
pct start $LXC_ID
sleep 5

# -----------------------------
# Install Docker & NGINX inside
# -----------------------------
echo "[*] Installing Docker & nginx container for ISO hosting..."

pct exec $LXC_ID -- bash -c "apt update && apt install -y curl ca-certificates gnupg lsb-release"

pct exec $LXC_ID -- bash -c "
  mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
  echo 'deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \$(lsb_release -cs) stable' > /etc/apt/sources.list.d/docker.list && \
  apt update && apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
"

# -----------------------------
# Mount NFS Share
# -----------------------------
echo "[*] Mounting NFS share..."

pct exec $LXC_ID -- bash -c "
  apt install -y nfs-common && \
  mkdir -p /mnt/isos && \
  echo '$NFS_SERVER:$NFS_EXPORT_PATH /mnt/isos nfs defaults 0 0' >> /etc/fstab && \
  mount -a
"

# -----------------------------
# Start NGINX Container
# -----------------------------
echo "[*] Running nginx Docker container to serve /mnt/isos..."

pct exec $LXC_ID -- docker run -d \
  --name iso-server-nginx \
  -v /mnt/isos:/usr/share/nginx/html:ro \
  -p 8080:80 \
  nginx

# -----------------------------
# Done
# -----------------------------
echo "[✅] ISO server deployed!"
echo "   ➤ Accessible at: http://$IP_ADDRESS:8080"
