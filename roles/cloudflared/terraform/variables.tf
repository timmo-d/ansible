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
  description = "List of hostnames for the Origin CA cert"
}

variable "cert_validity_days" {
  type        = number
  default     = 5475
  description = "Validity period in days"
}
