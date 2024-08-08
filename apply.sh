#!/bin/bash

read -sp 'Enter SSH password: ' SSH_PASSWORD
echo

# Run Terraform
terraform apply -auto-approve

# Get the IP address from Terraform output
LINODE_IP=$(terraform output -raw linode_instance_ip)

# Generate Ansible inventory
echo "[linode]" > ansible/inventory.ini
echo "$LINODE_IP" >> ansible/inventory.ini

# Run Ansible Playbook
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml --extra-vars "ansible_ssh_pass=$SSH_PASSWORD ansible_user=root"
