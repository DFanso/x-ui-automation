#!/bin/bash

# Run Terraform
terraform apply -auto-approve

# Get the IP address from Terraform output
LINODE_IP=$(terraform output -raw linode_instance_ip)

# Generate Ansible inventory
echo "[linode]" > inventory.ini
echo "$LINODE_IP" >> inventory.ini

# Run Ansible Playbook
ansible-playbook -i inventory.ini playbook.yml --extra-vars "ansible_ssh_private_key_file=/key ansible_user=root"
