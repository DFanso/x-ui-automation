terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

module "linode_instance" {
  source = "./modules/linode"

  linode_token   = var.linode_token
  instance_label = var.instance_label
  region         = var.region
  type           = var.type
  image          = var.image
  root_pass      = var.root_pass
  ssh_key        = var.ssh_key
  ssh_private_key = var.ssh_private_key
}

module "cloudflare_record" {
  source = "./modules/cloudflare"

  cloudflare_email   = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  zone_id            = var.cloudflare_zone_id
  record_name        = "vpn.dfanso.dev"
  ip_address         = module.linode_instance.linode_instance_ip
}

