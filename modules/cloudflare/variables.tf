variable "cloudflare_email" {
  description = "Cloudflare account email"
  type        = string
}

variable "cloudflare_api_key" {
  description = "Cloudflare API key"
  type        = string
}

variable "zone_id" {
  description = "The DNS zone ID to manage"
  type        = string
}

variable "record_name" {
  description = "The name of the DNS record"
  type        = string
}

variable "ip_address" {
  description = "The IP address for the A record"
  type        = string
}

variable "ttl" {
  description = "The TTL for the DNS record"
  type        = number
  default     = 1
}
