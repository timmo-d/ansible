# monitoring_setup

This role prepares a hardened monitoring node providing NIDS/NTA/HIDS, metrics, visualization, centralized logging, and host firewall configuration on **Ubuntu 24.04 LTS**.

**Included components**
- Suricata (IDS/IPS)
- Zeek (Network Traffic Analysis)
- OSSEC (local HIDS)
- Prometheus (metrics)
- Grafana (dashboards)
- rsyslog (log collection/forwarding)
- UFW (host firewall)

## Compliance alignment
- **DISA Ubuntu STIG**: default-deny firewall, SSH hardening, log management, FIPS-validated crypto (where applicable), least functionality.
- **NSA Network Infrastructure Security Guidance**: restrict management plane, monitor at choke points, segment mgmt networks, logging and time sync.
- **IDPS SRG (NIST 800-53 derived)**: SI-4/4(2) monitoring, AU-* logging requirements.

See `group_vars/monitoring/main.yml` and this role's `defaults/main.yml` for tunable parameters.

## Handlers
All services notify appropriate handlers to restart on config changes.

## Files
- `files/prometheus_alert_rules.yml`: example alert rules
- `files/grafana_dashboard_config.json`: example Grafana dashboard (importable)
- `files/kibana_dashboard_config.json`: example Kibana dashboard (for SIEM visuals)
- `files/elasticsearch_logrotate.conf`, `files/suricata_logrotate.conf`: rotate large logs.

## Templates
All service configs are **Jinja2 templates** with comments describing security choices:
- `templates/suricata.yaml.j2`
- `templates/zeek.cfg.j2`
- `templates/ossec.conf.j2`
- `templates/prometheus.yml.j2`
- `templates/grafana.ini.j2`
- `templates/rsyslog.conf.j2`
