output "origin_certificate" {
  value = cloudflare_origin_ca_certificate.origin_cert.certificate
}
