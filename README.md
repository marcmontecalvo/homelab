# homelabHomelab Infrastructure Overview

Welcome to the marcmontecalvo/homelab repository. This repo serves as a source of truth for automating, documenting, and managing a fully self-hosted homelab environment. The system is designed for flexibility, performance, and fun projects like self-hosted media, home automation, and secure remote access.

:house: Homelab Goals

Infrastructure as Code - Reproducible environment config using scripts and GitHub.

Isolated VLANs - Network segmentation for security and service organization.

Self-hosted Everything - Media streaming, automation, personal cloud.

Security - Proper firewall segmentation, proxy authentication, and access control.

Scalability - Easy to add more nodes and services.

:hammer_and_wrench: Core Technologies

Tech

Purpose

Proxmox VE

Virtualization and container orchestration

OPNsense

Firewall, VLANs, DHCP, gateway management

Docker

Application hosting with Portainer

NGINX Proxy Manager (NPM)

Reverse proxy with SSL management

Synology NAS

NFS storage for backups and media

GitHub

Script + configuration source control

:file_folder: Repository Structure

.
├── bootstrap/                # Initial provisioning scripts
│   └── setup-firewall-rules.sh   # Firewall setup for internal VLANs
├── containers/              # Container setup scripts (TBD)
├── backups/                 # Backup/restore tools (TBD)
├── networking/              # Network/VLAN mapping and info (TBD)
├── README.md                # This file

:satellite: Network Design

VLAN ID

Purpose

Subnet

Notes

20

IoT Automation

10.10.20.0/24

Home Assistant, Zigbee, etc.

30

Media Streaming

10.10.30.0/24

Plex, Audiobookshelf, etc.

40

Infra Services

10.10.40.0/24

NPM, Portainer, DNS, etc.

50

Media Download

10.10.50.0/24

Sonarr, Radarr, qBittorrent

60

DMZ / Public-facing

10.10.60.0/24

Reverse proxy or isolated web

99

LAN (Mgmt)

10.10.99.0/24

Firewall, Proxmox mgmt

:lock: Security Practices

VLAN segmentation limits lateral movement

setup-firewall-rules.sh opens only required access to the OPNsense firewall

NGINX Proxy Manager with Let's Encrypt secures external access

Vaultwarden and Authentik planned for secrets and identity

:rocket: Setup Guide (Quick Start)

# On OPNsense (after initial shell access)
curl -s https://raw.githubusercontent.com/marcmontecalvo/homelab/main/bootstrap/setup-firewall-rules.sh | sh

:bookmark_tabs: Future Plans



:handshake: Contributions

This is a personal project, but ideas and feedback are always welcome!

:memo: License

This repository is for personal homelab use and shared for educational purposes. Use at your own discretion.

Maintained by @marcmontecalvo