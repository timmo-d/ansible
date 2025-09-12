# Ubuntu 24.04 Hardening Role — STIG & USG Compliance

## Overview
This role enforces DoD STIG controls for Ubuntu 24.04, mapped to official Rule IDs and tagged for USG traceability. It is modular, auditable, and designed for future-proofing.

## Structure
- `tasks/stig_matrix.yml`: Core STIG controls with Rule ID tags
- `defaults/main.yml`: Tunable parameters
- `handlers/main.yml`: Service restarts
- `README.md`: Documentation and audit notes

## Compliance Mapping
| Control Description               | Rule ID                  | USG Tag |
|----------------------------------|--------------------------|---------|
| Install auditd                   | SV-230346r627751_rule    | usg     |
| Configure auditd retention       | SV-230347r627752_rule    | usg     |
| Disable core dumps               | SV-230345r627750_rule    | usg     |
| Restrict cron access             | SV-230348r627753_rule    | usg     |
| SHA-512 password hashing         | SV-230349r627754_rule    | usg     |
| Disable unused filesystems       | SV-230350r627755_rule    | usg     |
| Secure /etc/passwd               | SV-230351r627756_rule    | usg     |
| Secure /etc/shadow               | SV-230352r627757_rule    | usg     |
| Disable IPv6                     | SV-230353r627758_rule    | usg     |
| SSH protocol 2 only              | SV-230354r627759_rule    | usg     |

## Usage
Include this role in your `site.yml` and ensure `stig_matrix.yml` is invoked. Customize via `group_vars/all.yml` if needed.

## Audit Notes
Each task is tagged with `stig` and `usg` for traceability. Logs are stored in `/var/log/ansible-hardening.log` if logging is enabled.
