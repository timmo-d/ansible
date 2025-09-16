variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  type        = string
}

variable "tunnel_name" {
  type        = string
  default     = "home-edge"
}
