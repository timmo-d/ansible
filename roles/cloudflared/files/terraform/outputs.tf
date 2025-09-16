output "tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
}

output "tunnel_credentials_json" {
  value = jsonencode({
    AccountTag   = var.cloudflare_account_id
    TunnelSecret = base64encode(random_password.tunnel_secret.result)
    TunnelID     = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
  })
  sensitive = true
}
