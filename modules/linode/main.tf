terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
    }
  }
}

resource "linode_instance" "example" {
  label = var.instance_label
  region = var.region
  type   = var.type
  image  = var.image

  root_pass = var.root_pass

  authorized_keys = [var.ssh_key]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key)
      host        = self.ip_address
    }

    inline = [
      "chmod +x /root/scripts.sh",
      "/root/scripts.sh"
    ]
  }

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key)
      host        = self.ip_address
    }

    source      = "${path.module}/scripts/scripts.sh"
    destination = "/root/scripts.sh"
  }
}