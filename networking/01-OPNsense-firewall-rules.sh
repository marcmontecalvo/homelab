#!/bin/sh

# 01-OPNsense-firewall-rules.sh
# Adds VLAN access to OPNsense (Web UI, SSH) and ISO server

pfctl -a customrules -f - <<EOF
# Web UI Access
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.99.1 port 443 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.99.1 port 443 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.99.1 port 443 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.99.1 port 443 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.99.1 port 443 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.99.0/24 to 10.10.99.1 port 443 keep state

# SSH Access
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.99.1 port 22 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.99.0/24 to 10.10.99.1 port 22 keep state

# ISO Server Access (port 8080 on 10.10.40.11)
pass in quick on vtnet0 inet proto tcp from 10.10.20.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.30.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.40.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.50.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.60.0/24 to 10.10.40.11 port 8080 keep state
pass in quick on vtnet0 inet proto tcp from 10.10.99.0/24 to 10.10.40.11 port 8080 keep state
EOF

echo "✅ OPNsense firewall rules for VLAN access and ISO server are now loaded."