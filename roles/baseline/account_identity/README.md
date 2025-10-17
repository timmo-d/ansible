
# account_identity (within baseline role)

**Purpose:** Controls for `account_identity` aligned to **Ubuntu 24.04 LTS DISA‑STIG**.

## How this folder is used
- These are *not standalone roles*; they are included by the `baseline` role via `import_tasks`.
- Each file in `tasks/` maps to a control area and is guarded by `enable_*` switches in `roles/baseline/defaults/main.yml`.
- Templates for this category live under `roles/baseline/account_identity/templates/` and are referenced with `src: "{ '{' } role_path { '}' }/account_identity/templates/<file>.j2"`.

## Validation
- Run **USG** (`usg audit disa_stig`, optional `usg fix disa_stig`).
- Run **OpenSCAP**; the `continuous_monitoring/oscap_scan.yml` task auto-detects the Ubuntu 24.04 SCAP datastream.
