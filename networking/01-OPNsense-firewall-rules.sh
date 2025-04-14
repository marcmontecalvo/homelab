#!/bin/sh

# Adds pf rules for internal VLAN access to OPNsense WebUI + SSH

RULES="
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
"

echo "$RULES" | pfctl -a "customrules" -f -
