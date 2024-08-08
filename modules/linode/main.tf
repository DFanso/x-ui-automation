terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

provider "linode" {
  token = var.linode_token
}

resource "linode_instance" "example" {
  label = var.instance_label
  region = var.region
  type   = var.type
  image  = var.image

  root_pass = var.root_pass

  authorized_keys = [var.ssh_key]
}
