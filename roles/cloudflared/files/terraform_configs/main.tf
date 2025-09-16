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

resource "cloudflare_origin_ca_certificate" "origin_cert" {
  csr                = file("${path.module}/origin.csr")
  hostnames          = var.cloudflare_hostnames
  requested_validity = var.cert_validity_days
  request_type       = "origin-rsa"
}
