# V-ID ↔ Task Mapping (Ubuntu 24.04 LTS STIG)

| V-ID | Rule ID | Title | Category | Task Path | Enable Var | Notes |
|------|---------|-------|----------|-----------|------------|-------|
| V-270744 | UBTU-24-600030 | Implement NIST FIPS-validated cryptography | crypto | `roles/baseline/crypto/tasks/enable_fips_mode.yml` | `enable_enable_fips_mode` | Requires Ubuntu Pro; adds fips=1 to GRUB; enables fips-updates |
| V-270736 | (see STIG) | Map identity for PKI-based auth | account_identity | `roles/baseline/account_identity/tasks/pki_auth_mapping.yml` | `enable_pki_auth_mapping` | Site-specific SSSD/PKI realm |
| V-270748 | (see STIG) | Limit sudo to authorized | access_control | `roles/baseline/access_control/tasks/limit_sudo_group.yml` | `enable_limit_sudo_group` | Uses approved_sudo_users |
| V-270714 | (see STIG) | No blank/null PAM passwords | account_identity | `roles/baseline/account_identity/tasks/disable_blank_passwords.yml` | `enable_disable_blank_passwords` | Locks any empty password accounts |
| V-270656 | UBTU-24-100400 | auditd installed | logging_audit | `roles/baseline/logging_audit/tasks/install_auditd.yml` | `enable_install_auditd` | Install + enable auditd |
| V-270651 | UBTU-24-100120 | AIDE periodic ≤30 days | fs_storage | `roles/baseline/fs_storage/tasks/aide_periodic_check.yml` | `enable_aide_periodic_check` | Monthly cron AIDE check |
| V-270829 | UBTU-24-901350 | Audit log group ownership root | logging_audit | `roles/baseline/logging_audit/tasks/auditd_log_group_root.yml` | `enable_auditd_log_group_root` | Sets log_group=root; fixes perms |