# 🏠 Homelab Infrastructure

A complete overview and configuration baseline for a self-hosted homelab using Proxmox, OPNsense, VLAN segmentation, containerization, and more.

---

## 🧠 Overview

This repo contains all bootstrap scripts, infrastructure plans, container setup references, and networking configs for a multi-node, VLAN-segmented homelab setup.

---

## 🔧 Core Infrastructure

| Component               | Description                                      |
| ----------------------- | ------------------------------------------------ |
| **Proxmox (Main)**      | `verahost` – primary hypervisor, VLAN aware      |
| **Proxmox (Secondary)** | `proxmox` – legacy system, being migrated        |
| **N100 NUC**            | Dedicated to Plex with GPU passthrough           |
| **NAS (DS1520+)**       | NFS shares for media, torrents, configs, backups |
| **OPNsense**            | Virtualized firewall & router, VLAN aware        |

---

## 🧱 VLAN Design

| VLAN Tag | CIDR            | Purpose               | Alias             |
| -------- | --------------- | --------------------- | ----------------- |
| 20       | `10.10.20.0/24` | IoT Automation        | `iot-automation`  |
| 30       | `10.10.30.0/24` | Media Streaming       | `media-streaming` |
| 40       | `10.10.40.0/24` | Infrastructure        | `infra-services`  |
| 50       | `10.10.50.0/24` | Media Downloads       | `media-download`  |
| 60       | `10.10.60.0/24` | DMZ / Public          | `dmz-public`      |
| 99       | `10.10.99.0/24` | Admin / Firewall MGMT | `infra-core`      |

---

## 🎯 Goals

- ✅ Migrate Audiobookshelf to new host
- ✅ Migrate NPM container and reconfigure domain access
- ⬜ Add legacy Proxmox server (`proxmox`) as node to cluster
- ⬜ Backup & restore Home Assistant post-node join
- ⬜ Create Docker LXC/VM for Arr stack + QBit + NordVPN
- ⬜ Add Nextcloud container
- ⬜ Setup Minecraft servers with Velocity proxy + Bedrock support
- ⬜ Configure Plex passthrough on N100 node
- ⬜ Deploy Vaultwarden + Authentik for SSO / access control
- ⬜ Build secure, SSO-gated homelab dashboard (homepage)

---

## 🚀 Setup Scripts

**🔒 Firewall Rules (Paste-safe or GitHub method):**

```bash
# One-liner to run from OPNsense terminal
curl -s https://raw.githubusercontent.com/marcmontecalvo/homelab/main/bootstrap/setup-firewall-rules.sh | sh
```

Or clone this repo and run manually from shell.

---

## 📁 Folder Structure

```text
homelab/
├── bootstrap/               # One-time setup and security scripts
│   └── setup-firewall-rules.sh
├── containers/              # App-specific bootstrap configs
├── backups/                 # Notes about backup strategy
├── networking/              # VLAN maps, static IP plans, DHCP config
└── README.md                # You are here
```

---

## 💡 Notes

- All internal static IPs are assigned in the `.1 - .99` range.
- DHCP pools start from `.100` upward per subnet.
- All traffic between VLANs is explicitly controlled by OPNsense firewall rules.
- `.local` hostnames are avoided in favor of FQDNs managed via NPM.
- Public access services are routed via NGINX Proxy Manager using Let's Encrypt certs.

---

## 📌 To-Do Enhancements

- [ ] Add markdown diagrams (network flow, storage layout)
- [ ] Setup GitHub Actions to test new config scripts
- [ ] Create docker-compose samples for each app
- [ ] Auto-detect and configure VLAN IPs in bootstrap

---

## 🙌 Credits

Maintained by **Marc Montecalvo**  
Repo: [github.com/marcmontecalvo/homelab](https://github.com/marcmontecalvo/homelab)



curl -s https://raw.githubusercontent.com/marcmontecalvo/homelab/refs/heads/main/bootstrap/optional-iso-server-setup.sh | bash
