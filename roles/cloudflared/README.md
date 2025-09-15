# timmos.cloudflare_access

Provision Cloudflare Access applications for self-hosted services using Ansible. This role is designed to be modular, idempotent, and audit-traceable — ideal for homelab setups, Zero Trust deployments, and STIG-aligned infrastructure.

## 🚀 Features

- Creates Cloudflare Access apps via API  
- Supports multiple services (Sonarr, Radarr, etc.)  
- Idempotent: skips creation if app already exists  
- Modular and Galaxy-compliant  
- Designed for CI/CD pipelines and audit safety

## 📦 Requirements

- Ansible 2.10+  
- Cloudflare API token with Access app permissions  
- Cloudflare account ID  
- Managed domain in Cloudflare (e.g. `timmos.com.au`)

## 🔧 Role Variables

```yaml
cloudflare_api_token: "<your_api_token>"
cloudflare_account_id: "<your_account_id>"
cloudflare_zone: "timmos.com.au"

cloudflare_access_apps:
  - name: "Sonarr"
    domain: "sonarr.timmos.com.au"
    local_service: "http://192.168.1.100:8989"
    email: "admin@timmos.com.au"
  - name: "Radarr"
    domain: "radarr.timmos.com.au"
    local_service: "http://192.168.1.100:7878"
    email: "admin@timmos.com.au"
```

## 📂 Example Playbook

```yaml
- name: Provision Cloudflare Access apps
  hosts: localhost
  gather_facts: false
  roles:
    - role: timmos.cloudflare_access
      vars:
        cloudflare_api_token: "{{ vault_cloudflare_token }}"
        cloudflare_account_id: "abc123xyz"
        cloudflare_zone: "timmos.com.au"
        cloudflare_access_apps:
          - name: "Sonarr"
            domain: "sonarr.timmos.com.au"
            local_service: "http://192.168.1.100:8989"
            email: "admin@timmos.com.au"
          - name: "Radarr"
            domain: "radarr.timmos.com.au"
            local_service: "http://192.168.1.100:7878"
            email: "admin@timmos.com.au"
```

## 🔐 Security Notes

- API token should be stored securely (e.g. Ansible Vault)  
- Role avoids duplicate app creation via domain matching  
- Designed for Zero Trust environments

## 🧪 Testing

You can validate the role using Molecule or run it against a test domain with dummy services. Logs include full API responses for audit traceability.

## 📜 License

MIT

## 🤝 Author

T — methodical, adaptable, and deeply invested in secure automation workflows.
