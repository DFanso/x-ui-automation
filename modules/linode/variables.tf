variable "linode_token" {
  description = "Linode API token"
  type        = string
}

variable "instance_label" {
  description = "Label for the Linode instance"
  type        = string
}

variable "region" {
  description = "Region where the Linode instance will be created"
  type        = string
  default     = "ap-south"
}

variable "type" {
  description = "Type of the Linode instance"
  type        = string
  default     = "g6-nanode-1"
}

variable "image" {
  description = "Image to use for the Linode instance"
  type        = string
  default     = "linode/ubuntu22.04"
}

variable "root_pass" {
  description = "Root password for the Linode instance"
  type        = string
}

variable "ssh_key" {
  description = "SSH public key for access"
  type        = string
}

variable "ssh_private_key" {
  description = "Path to the private SSH key"
  type        = string
}
