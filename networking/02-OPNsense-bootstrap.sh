#!/bin/sh
# setup-bootstrap.sh
# Run this first after fresh OPNsense deployment (or from SSH)

# 1. Add firewall rules to allow VLAN traffic to OPNsense web UI + SSH
curl -s https://raw.githubusercontent.com/marcmontecalvo/homelab/main/bootstrap/setup-firewall-rules.sh | sh

# 2. Confirm connectivity
ping -c 2 10.10.99.1 || echo "⚠️ Unable to ping firewall – check VLAN and rules"

# 3. Set Hostname (Optional)
hostname="opnsense"
echo "$hostname" > /etc/hostname
hostname $hostname

# 4. Optional: Install curl (already included in recent OPNsense, but good for Proxmox VMs)
# pkg install -y curl

# 5. Reminder
echo "✅ Bootstrap script complete. Next steps: VLAN interfaces + static IPs + services."