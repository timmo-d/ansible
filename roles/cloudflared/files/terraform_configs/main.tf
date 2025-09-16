terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_global_api_key
}

# 1. Create the tunnel
resource "cloudflare_zero_trust_tunnel_cloudflared" "home_edge" {
  account_id = var.cloudflare_account_id
  name       = "home-edge"
  secret     = random_password.tunnel_secret.result
}

# 2. Generate a strong secret for the tunnel
resource "random_password" "tunnel_secret" {
  length  = 64
  special = false
}

# 3. Create DNS route for the tunnel
resource "cloudflare_zero_trust_tunnel_route" "home_edge_route" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.home_edge.id
  network    = "0.0.0.0/0"
}

# 4. Output the token JSON
output "tunnel_credentials_json" {
  value     = jsonencode({
    AccountTag   = var.cloudflare_account_id
    TunnelSecret = base64encode(random_password.tunnel_secret.result)
    TunnelID     = cloudflare_zero_trust_tunnel_cloudflared.home_edge.id
  })
  sensitive = true
}
