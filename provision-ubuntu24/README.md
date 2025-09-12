# 🛡️ Ubuntu 24.04 STIG Hardening Role

This Ansible role implements full DoD STIG compliance for Ubuntu 24.04 LTS. It is modular, traceable, and future-proofed for evolving benchmarks. Each control is mapped to its official Rule ID and grouped by domain for clarity and auditability.

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
                        │        NGINX (127.0.0.1:80) │
                        │  Hardened reverse proxy     │
                        └────────────┬───────────────┘
                                     │
                                     ▼
         ┌────────────────────────────────────────────────────────────┐
         │ Internal Services (192.168.1.100)                          │
         │ ├─ radarr.timmos.com.au  → port 7878                      │
         │ ├─ sonarr.timmos.com.au  → port 8989                      │
         │ ├─ prowlarr.timmos.com.au → port 9696                     │
         │ ├─ lidarr.timmos.com.au   → port 8686                     │
         │ ├─ kodi.timmos.com.au     → port 8888                     │
         │ ├─ whisparr.timmos.com.au → port 6969                     │
         │ ├─ readarr.timmos.com.au  → port 8787                     │
         │ ├─ huntarr.timmos.com.au  → port 9705                     │
         │ └─ qbittorrent.timmos.com.au → port 8080                  │
         └────────────────────────────────────────────────────────────┘
```

---

## 🔐 STIG Control Domains

Each control domain is implemented as a separate task file and conditionally included via `main.yml`. Controls are tagged with:

- ✅ Official STIG Rule ID (e.g. `UBUNTU-24-010050`)
- ✅ Domain tag (e.g. `ssh`, `auditd`)
- ✅ `stig` and `usg` for audit traceability

### Domains

| Domain             | File                  | Description                                 |
|--------------------|-----------------------|---------------------------------------------|
| `auditd`           | `auditd.yml`          | Logging and retention                       |
| `ssh`              | `ssh.yml`             | Protocol and root access restrictions       |
| `pam`              | `pam.yml`             | Password enforcement                        |
| `banner`           | `banner.yml`          | DoD login banner                            |
| `cron`             | `cron.yml`            | Scheduled task restrictions                 |
| `fips`             | `fips.yml`            | Cryptographic module enforcement            |
| `ctrl_alt_del`     | `ctrl_alt_del.yml`    | Reboot key sequence disablement             |
| `file_permissions` | `file_permissions.yml`| Sensitive file ownership and mode           |
| `disruption`       | `disruption.yml`      | GUI and guest account disablement           |

---

## ⚙️ Configuration

Customize control execution via `group_vars/all.yml`:

```yaml
stig_enabled_tags:
  - auditd
  - ssh
  - pam
  - banner
  - cron
  - fips
  - ctrl_alt_del
  - file_permissions

ubuntu24stig_disruption_high: false
ubtu24stig_run_audit: true
```

---

## 🚀 Usage

Run the playbook:

```bash
ansible-playbook -i inventory site.yml
```

Ensure your `site.yml` includes the `hardening` role:

```yaml
- name: Apply STIG hardening
  hosts: all
  become: true
  roles:
    - hardening
```

---

## 📎 Audit & Traceability

- All tasks are tagged with `stig`, `usg`, and their Rule ID.
- Modular structure supports selective execution and audit filtering.
- Container detection logic skips non-applicable controls.
- Optional Goss integration available for post-deployment validation.

---

## 📘 References

- [UBUNTU24-STIG GitHub](https://github.com/ansible-lockdown/UBUNTU24-STIG)
- [STIG Viewer: Ubuntu 24.04 LTS](https://stigviewer.com/stigs/canonical_ubuntu_24.04_lts)
- [DISA STIG Documentation](https://public.cyber.mil/stigs/)

---

Let me know if you'd like to add Goss audit scaffolding, generate a compliance dashboard, or automate STIG delta tracking across releases.
