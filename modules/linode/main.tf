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

  provisioner "file" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key)
      host        = self.ip_address
      timeout     = "5m"
    }

    source      = "${path.root}/scripts/install_x_ui.sh"
    destination = "/root/install_x_ui.sh"
  }

  # Introduce a delay to wait for DNS propagation
  provisioner "local-exec" {
    command = "sleep 120"  # Adjust the sleep duration as needed
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key)
      host        = self.ip_address
      timeout     = "5m"
    }

    inline = [
      "ls -l /root",        # List files in /root to check if the script is there
      "chmod +x /root/install_x_ui.sh",
      "/root/install_x_ui.sh"
    ]
  }
}

