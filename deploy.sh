#!/bin/bash

set -e  # Exit immediately on error
echo "🚀 Starting 3-Tier Terraform + Ansible Deployment..."

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

echo "⏫ Copying PEM and Ansible files to Bastion..."
BASTION_IP=$(terraform output -raw bastion_public_ip)

scp -o StrictHostKeyChecking=no -i ~/.ssh/NayaWala ~/.ssh/Nayawala ubuntu@$BASTION_IP:/home/ubuntu/
scp -o StrictHostKeyChecking=no -i ~/.ssh/NayaWala -r ./ansible ubuntu@$BASTION_IP:/home/ubuntu/

echo "📡 Running Ansible from Bastion..."
ssh -o StrictHostKeyChecking=no -i ~/.ssh/NayaWala ubuntu@$BASTION_IP << EOF
  sudo apt update
  sudo apt install -y ansible
  cd ansible
  chmod 400 ../NayaWala
  ansible-playbook -i hosts.ini web-setup.yml --private-key=../NayaWala
  ansible-playbook -i hosts.ini app-setup.yml --private-key=../NayaWala
EOF

chmod +x db_env.sh
echo "running db_env.sh"
./db_env.sh

echo "✅ Deployment completed successfully!"
