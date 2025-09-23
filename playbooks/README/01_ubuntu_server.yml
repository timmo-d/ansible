# Ubuntu 24.04 LTS STIG Baseline (Ansible)

This repository applies a **Defense Information Systems Agency (DISA) STIG-inspired** hardening baseline to Ubuntu **24.04 LTS** using **Ansible**, grouped by major security areas. It aims to implement the configuration patterns typically required by the Ubuntu 24.04 LTS STIG benchmark, including time sync, SSH hardening, auditing, password policy, logging protections, kernel hardening, and FIPS enablement.

> ⚠️ **Caution:** Security hardening can **lock you out** (especially SSH, PAM, UFW, MFA, and FIPS changes). Test in a lab first and review variables in `group_vars/all.yml`.

## Project Structure (Galaxy-style)
```
ubuntu-stig/
├── ansible.cfg
├── inventories/
│   └── prod/hosts.ini
├── group_vars/
│   └── all.yml
├── requirements.yml
├── roles/
│   ├── time_sync/
│   ├── network_security/
│   ├── ssh_hardening/
│   ├── file_integrity_audit/
│   ├── auth_access/
│   ├── crypto_fips/
│   ├── logging_journal/
│   ├── system_hardening/
│   ├── session_timeouts/
│   ├── packages_patching/
│   └── compliance_lockdown/
├── site.yml
└── README.md
```

## Prerequisites
- **Control node**: Ansible 2.15+ (Python 3.9+ recommended)
- **Managed hosts**: Ubuntu **24.04 LTS** (Noble)
- Install required collection:
  ```bash
  ansible-galaxy collection install -r requirements.yml
  ```

## Inventory
Managed in Semaphore UI
If running from CLI: Edit `inventory/hosts.yml` and update with your target hosts.

## Variables to Review (group_vars/all.yml)
- **Time**: `chrony_servers`, `remove_timesyncd`
- **Firewall**: `ufw_*`
- **SSH**: ciphers/MACs/KEX, X11Forwarding, idle timeouts
- **Auth**: pwquality (length/complexity), faillock (deny/interval), disable root, remove `nullok`
- **FIPS**: `enable_fips` (requires Ubuntu Pro token) and `ubuntu_pro_token`
- **Logs**: permissions/ownership enforcement
- **Sysctl**: `kernel.dmesg_restrict`, `tcp_syncookies`, ASLR

## Run
Execute from Semaphore UI, or from CLI:
```bash
ansible-playbook -i inventories/prod/hosts.ini site.yml
```

### Tags
Each role includes tags, e.g. `--tags ssh,hardening`.

## Role Overview & STIG Mapping (high-level)
- **time_sync**: chrony install/config; remove timesyncd/ntp.
- **network_security**: remove telnet/rsh; enable UFW with default deny inbound, allow SSH first.
- **ssh_hardening**: FIPS-aligned crypto, X11 off, idle timeout, no empty passwords.
- **file_integrity_audit**: AIDE; auditd with watches for sensitive files, privileged commands, and syscalls; immutable rules.
- **auth_access**: pwquality (minlen 15, difok 8, credits), `pam_faildelay`, `pam_faillock`, SHA512+rounds, lock root, remove `nullok`.
- **crypto_fips**: Ubuntu Pro FIPS activation (optional).
- **logging_journal**: ownership/permissions on `/var/log` and journald.
- **system_hardening**: sysctl (dmesg_restrict, syncookies, ASLR), disable kdump.
- **session_timeouts**: SSH ClientAlive settings.
- **packages_patching**: APT signature enforcement; unattended cleanup.
- **compliance_lockdown**: audit file perms; immutable `-e 2`; secure audit log dir/file.

## Verification (quick checks)
- `sshd -T | grep -E 'ciphers|macs|kexalgorithms|clientalive'`
- `sudo ufw status verbose`
- `sudo auditctl -s && sudo auditctl -l | head`
- `grep -E 'PASS_MIN_DAYS|PASS_MAX_DAYS' /etc/login.defs`
- `sysctl kernel.dmesg_restrict net.ipv4.tcp_syncookies kernel.randomize_va_space`

## Rollback Tips
- Keep console/serial access.
- Before applying, snapshot VM.
- If SSH fails to restart, the handler prevents restart on invalid config; fix `/etc/ssh/sshd_config` and rerun.
- For audit rule immutability (`-e 2`), you must **reboot** or edit from early boot to change rules.

## Notes
- This baseline is patterned after DISA STIG requirements for Ubuntu 24.04 LTS. Exact compliance depends on your chosen profile and any organizational overlays.

## License
MIT
