terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
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

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

resource "null_resource" "wait_for_dns" {
  depends_on = [module.cloudflare_record]
  provisioner "local-exec" {
    command = "sleep 10"  # Adjust the sleep duration as needed
  }
}

module "cloudflare_record" {
  source = "./modules/cloudflare"

  cloudflare_email = var.cloudflare_email
  cloudflare_api_key = var.cloudflare_api_key
  zone_id = var.cloudflare_zone_id
  record_name = var.record_name
  ip_address = module.linode_instance.linode_instance_ip
}

module "linode_instance" {
  source = "./modules/linode"

  linode_token    = var.linode_token
  instance_label  = var.instance_label
  region          = var.region
  type            = var.type
  image           = var.image
  root_pass       = var.root_pass
  ssh_key         = var.ssh_key
  ssh_private_key = var.ssh_private_key
}

resource "null_resource" "provision_linode" {
  depends_on = [null_resource.wait_for_dns]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key)
      host        = module.linode_instance.linode_instance_ip
      timeout     = "5m"
    }

    inline = [
      "chmod +x /root/install_x_ui.sh",
      "/root/install_x_ui.sh"
    ]
  }
}
