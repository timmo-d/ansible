output "tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
}

output "tunnel_credentials_json" {
  value     = cloudflare_zero_trust_tunnel_cloudflared.tunnel.credentials_file
  sensitive = true
}
