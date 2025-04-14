#!/bin/sh

# 01-OPNsense-firewall-rules.sh
# Adds rules to allow VLAN access to OPNsense services (Web UI, SSH) and ISO server

# Use pfctl to load custom rules
pfctl -a customrules -f - <<EOF
# Allow VLANs to access OPNsense Web UI (443) and SSH (22)
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.99.1 port 443 keep state

pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.99.1 port 443 keep state

pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.99.1 port 443 keep state

pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.99.1 port 443 keep state

pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.99.1 port 443 keep state

# Allow VLANs to reach the ISO server (hosted on 10.10.40.11 port 8080)
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.99.0/24 to 10.10.40.11 port 8080 keep state
EOF

# Reload pf to make sure the new rules take effect
pfctl -f /etc/pf.conf

echo "✅ OPNsense firewall rules for VLAN access and ISO server are now loaded."