#!/bin/bash

set -e  # Exit immediately on error

echo "🚀 Starting 3-Tier Terraform + Ansible Deployment..."

# Step 1: Navigate to the directory where this script is located
#cd "$(dirname "$0")"

# Step 2: Run Terraform
echo "📦 Initializing and Applying Terraform..."
terraform init
terraform apply -auto-approve

echo "Instance Getting ready"
sleep 60

echo "✅ Terraform provisioning completed."

# Step 3: Verify that hosts.ini was created by local-exec provisioners
echo "📄 Generated Ansible Inventory:"
cat ./ansible/hosts.ini

# Step 4: Run Ansible Playbook
echo "🚀 Running Ansible Playbook..."
cd ansible
ansible-playbook -i hosts.ini web-setup.yml
ansible-playbook -i hosts.ini app-setup.yml

chmod +x db_env.sh
echo "running db_env.sh"
./db_env.sh

echo "✅ Deployment completed successfully!"
