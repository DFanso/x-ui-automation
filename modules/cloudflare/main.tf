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
  api_key = var.cloudflare_api_key
}

resource "cloudflare_record" "a_record" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = "A"
  value   = var.ip_address
  ttl     = var.ttl
}

