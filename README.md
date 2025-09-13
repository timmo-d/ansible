# 🛡️ Reverse Proxy Maintenance Suite

This repository contains modular, Galaxy-compliant Ansible roles for deploying and maintaining a hardened reverse proxy infrastructure. It supports Nginx-based proxying, SSL management, monitoring, log rotation, and automated backups. Designed for operational resilience, audit traceability, and ease of future extension.

---

## 📦 Roles Overview

| Role         | Description                                                                 |
|--------------|-----------------------------------------------------------------------------|
| `nginx_proxy`| Deploys and configures Nginx as a reverse proxy with SSL and caching        |
| `certbot`    | Manages SSL certificates via Let's Encrypt with auto-renewal                |
| `monitoring` | Installs Prometheus Node Exporter for system metrics                        |
| `logrotate`  | Configures log rotation for Nginx and system logs                           |
| `backup`     | Automates daily backups of configs, logs, and certificates                  |

---

## 📁 Directory Structure

```bash
project/
├── inventories/
│   └── production/
│       └── inventory.yml
├── group_vars/
│   ├── web.yml
│   └── monitoring.yml
├── playbooks/
│   ├── deploy_proxy.yml
│   └── maintain_proxy.yml
├── roles/
│   ├── nginx_proxy/
│   ├── certbot/
│   ├── monitoring/
│   ├── logrotate/
│   └── backup/
```

---

## 🚀 Usage

### 1. Deploy Reverse Proxy

```bash
ansible-playbook -i inventories/production/inventory.yml playbooks/deploy_proxy.yml
```

### 2. Maintain Infrastructure

```bash
ansible-playbook -i inventories/production/inventory.yml playbooks/maintain_proxy.yml
```

---

## 🔐 Security & Compliance

- All roles are designed with audit traceability in mind.
- SSL certificates are auto-renewed and backed up daily.
- Log rotation prevents disk exhaustion and supports forensic review.
- Monitoring exposes system metrics for Prometheus scraping.

---

## 🧠 Customization

Edit `group_vars/web.yml` and `group_vars/monitoring.yml` to configure:

- Nginx ports, domains, SSL paths
- Cloudflared tunnel IDs and ingress rules
- Backup paths and retention policies

---

## 📚 Documentation

Each role includes:

- `tasks/main.yml`: Core logic
- `defaults/main.yml`: Configurable variables
- `templates/`: Jinja2 templates for config files
- `handlers/main.yml`: Service reloads
- `meta/main.yml`: Galaxy metadata

---

## 🤝 Contributions

Modular logic and audit-safe workflows are welcome. Please ensure:

- All tasks are idempotent
- Variables are scoped via `defaults/` or `group_vars/`
- Templates include conditional logic for optional features

---

## 🧾 License

MIT License. See `LICENSE` file for details.
