#!/bin/bash

set -e  # Exit on error
echo "🚀 Starting 3-Tier Terraform + Ansible Deployment..."

# Step 1: Run Terraform
echo "📦 Initializing and Applying Terraform..."
terraform init
terraform apply -auto-approve

echo "🕒 Waiting for EC2 instances to be ready..."
sleep 20  # Optional: Adjust based on instance boot time

echo "✅ Terraform provisioning completed."

# Step 2: Show generated Ansible inventory
echo "📄 Generated Ansible Inventory:"
cat ./ansible/hosts.ini

# Step 3: Copy files to Bastion host
echo "⏫ Copying PEM and Ansible files to Bastion..."
BASTION_IP=$(terraform output -raw bastion_public_ip)
PEM_PATH=~/3tier_Automation/NayaWala

scp -o StrictHostKeyChecking=no -i "$PEM_PATH" "$PEM_PATH" ubuntu@$BASTION_IP:.
scp -o StrictHostKeyChecking=no -i "$PEM_PATH" -r ./ansible ubuntu@$BASTION_IP:.
scp -o StrictHostKeyChecking=no -i "$PEM_PATH" -r ./sql ubuntu@$BASTION_IP:./ansible
scp -o StrictHostKeyChecking=no -i "$PEM_PATH" ./forms.html ubuntu@$BASTION_IP:./ansible
scp -o StrictHostKeyChecking=no -i "$PEM_PATH" ./submit.php ubuntu@$BASTION_IP:./ansible

# Step 4: SSH and run Ansible from Bastion
echo "📡 Running Ansible from Bastion..."
ssh -o StrictHostKeyChecking=no -i "$PEM_PATH" ubuntu@$BASTION_IP << 'EOF'
  set -e
  sudo apt update
  sudo apt install -y ansible
  cd ansible
  chmod 400 ../NayaWala
  ansible-playbook -i hosts.ini web-setup.yml
  ansible-playbook -i hosts.ini app-setup.yml
  ./db_env.sh
EOF

echo "sucessfully completed"
