# 🛡️ Ubuntu 24.04 Provisioning Stack — STIG-Compliant Infrastructure

This repository provisions a hardened Ubuntu 24.04 server using modular Ansible roles. It integrates DoD STIG controls, Cloudflare Tunnel for secure external access, and a loopback-only NGINX reverse proxy for internal services.

---

## 📐 Compliance Architecture Diagram

```text
                        ┌────────────────────────────┐
                        │      Cloudflare Edge       │
                        │  (TLS Termination + WAF)   │
                        └────────────┬───────────────┘
                                     │
                                     ▼
                        ┌────────────────────────────┐
                        │     Cloudflared Tunnel     │
                        │  (Secure outbound-only     │
                        │   connection to Cloudflare)│
                        └────────────┬───────────────┘
                                     │
                                     ▼
                        ┌────────────────────────────┐
                        │       NGINX (127.0.0.1:80) │
                        │  Hardened reverse proxy    │
                        └────────────┬───────────────┘
                                     │
                                     ▼
         ┌────────────────────────────────────────────────────────────┐
         │ Internal Services (192.168.1.100)                          │
         │ ├─ radarr.timmos.com.au  → port 7878                       │
         │ ├─ sonarr.timmos.com.au  → port 8989                       │
         │ ├─ prowlarr.timmos.com.au → port 9696                      │
         │ ├─ lidarr.timmos.com.au   → port 8686                      │
         │ ├─ kodi.timmos.com.au     → port 8888                      │
         │ ├─ whisparr.timmos.com.au → port 6969                      │
         │ ├─ readarr.timmos.com.au  → port 8787                      │
         │ ├─ huntarr.timmos.com.au  → port 9705                      │
         │ └─ qbittorrent.timmos.com.au → port 8080                   │
         └────────────────────────────────────────────────────────────┘
```

---

## 🔐 System Hardening — STIG & USG Compliance

This role enforces DoD STIG controls for Ubuntu 24.04. Each control is mapped to an official Rule ID and tagged for USG traceability.

### Key Controls

| Control Description               | Rule ID                  | USG Tag |
|----------------------------------|--------------------------|----------|
| Install auditd                   | SV-230346r627751_rule    | ✅      |
| Configure auditd retention       | SV-230347r627752_rule    | ✅      |
| Disable core dumps               | SV-230345r627750_rule    | ✅      |
| Restrict cron access             | SV-230348r627753_rule    | ✅      |
| SHA-512 password hashing         | SV-230349r627754_rule    | ✅      |
| Disable unused filesystems       | SV-230350r627755_rule    | ✅      |
| Secure /etc/passwd               | SV-230351r627756_rule    | ✅      |
| Secure /etc/shadow               | SV-230352r627757_rule    | ✅      |
| Disable IPv6                     | SV-230353r627758_rule    | ✅      |
| SSH protocol 2 only              | SV-230354r627759_rule    | ✅      |

📁 See: `roles/hardening/tasks/stig_matrix.yml`

---

## 🌐 NGINX Reverse Proxy — Loopback-Only Access

NGINX is configured to listen only on `127.0.0.1:80`, serving as a reverse proxy for internal services. TLS is terminated at the Cloudflare edge.

### Subdomain Routing

| Subdomain               | Backend IP:Port        |
|------------------------|-------------------------|
| radarr.timmos.com.au   | 192.168.1.100:7878      |
| sonarr.timmos.com.au   | 192.168.1.100:8989      |
| prowlarr.timmos.com.au | 192.168.1.100:9696      |
| lidarr.timmos.com.au   | 192.168.1.100:8686      |
| kodi.timmos.com.au     | 192.168.1.100:8888      |
| whisparr.timmos.com.au | 192.168.1.100:6969      |
| readarr.timmos.com.au  | 192.168.1.100:8787      |
| huntarr.timmos.com.au  | 192.168.1.100:9705      |
| qbittorrent.timmos.com.au | 192.168.1.100:8080   |

📁 See: `roles/nginx/templates/nginx.conf.j2`

---

## 🚇 Cloudflare Tunnel — Secure External Access

Cloudflared is installed and configured to proxy HTTPS traffic from Cloudflare to NGINX on `localhost:80`. No inbound ports are exposed.

### Highlights

- Tunnel registered via systemd
- Config file: `/etc/cloudflared/config.yml`
- Subdomain ingress mapped to internal services

📁 See:
- `roles/cloudflared/tasks/main.yml`
- `roles/cloudflared/templates/config.yml.j2`

---

## 🧰 Usage

To provision the system:

```bash
ansible-playbook -i inventory site.yml
```

Ensure your `group_vars/all.yml` includes:

```yaml
tunnel_id: <your-tunnel-id>
domain: timmos.com.au
```

---

## 📎 Audit & Traceability

All hardening tasks are tagged with `stig` and `usg` for compliance tracking. Logs can be optionally redirected to `/var/log/ansible-hardening.log`.

For future STIG updates, controls are modular and editable. You can extend the matrix or integrate with USG for automated compliance reporting.
