output "linode_instance_ip" {
  description = "The public IP address of the Linode instance"
  value       = linode_instance.example.ip_address
}
