output "linode_instance_ip" {
  description = "The public IP address of the Linode instance"
  value       = module.linode_instance.linode_instance_ip
}
