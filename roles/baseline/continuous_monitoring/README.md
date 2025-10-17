
# continuous_monitoring (within baseline role)

Purpose: Controls for `continuous_monitoring` aligned to Ubuntu 24.04 LTS DISA‑STIG.

* These are not standalone roles; they are included by the `baseline` role via `import_tasks`.
* Each task file is guarded by `enable_*` switches in `roles/baseline/defaults/main.yml`.
* Templates are under `roles/baseline/continuous_monitoring/templates/`.
