variable "cloudflare_email" {
  type        = string
  description = "Cloudflare account email"
}

variable "cloudflare_global_api_key" {
  type        = string
  description = "Cloudflare global API key"
}

variable "cloudflare_hostnames" {
  type        = list(string)
  description = "List of hostnames for the Origin CA certificate"
}

variable "cert_validity_days" {
  type        = number
  default     = 5475
  description = "Certificate validity period in days"
}

variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account ID"
}





variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
}

variable "tunnel_name" {
  type        = string
  default     = "home-edge"
}
