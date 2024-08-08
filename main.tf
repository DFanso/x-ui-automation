terraform {
  required_providers {
    linode = {
      source = "linode/linode"
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
}


