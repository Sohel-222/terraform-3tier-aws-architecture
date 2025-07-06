# 🚀 3-Tier Infrastructure Deployment Using Terraform Modules

---

## 🎯 Objective

Design and deploy a complete **3-tier web application architecture on AWS** using **Terraform modules** and **Ansible automation** for configuration.

---

## 🏗️ Project Requirements

### 🔹 Networking (VPC Setup)
- Custom VPC with:
  - Public and private subnets across 2 Availability Zones
  - Internet Gateway, NAT Gateway
  - Route Tables, Security Groups, NACLs

### 🔹 Web Tier (Public Subnet)
- 1 EC2 Instance
- Nginx + Registration form (`forms.html`)

### 🔹 Application Tier (Private Subnet)
- 1 EC2 Instance
- `submit.php` to process form & send data to DB

### 🔹 Database Tier (Private Subnet)
- Amazon RDS (MySQL)
- Private subnet, access only from App Tier

### 🔹 Automation Tools
- **Terraform modules** for:
  - VPC, EC2 (web & app), RDS, Security Groups
- **Ansible** for:
  - Installing packages
  - Deploying code
  - Server configuration via Bastion

---

## 🚀 How to Deploy

### 1️⃣ Clone the Repository

```bash
mkdir 3tier_Automation
cd 3tier_Automation
git clone https://github.com/your-username/your-repo-name.git .
```

### 2️⃣ Run the Deployment

```bash
chmod +x deploy.sh
./deploy.sh
```

✅ This will:
- Provision all infrastructure on AWS
- Use Bastion Host to run Ansible
- Automatically configure all servers (no manual steps needed)

---

## 📦 Project Structure

```bash
.
├── ansible
│   ├── app-setup.yml
│   ├── hosts.ini
│   └── web-setup.yml
├── clean.sh
├── deploy.sh
├── forms.html
├── main.tf
├── modules
│   ├── app/
│   ├── bastion/
│   ├── rds/
│   ├── sg/
│   ├── vpc/
│   └── web/
├── outputs.tf
├── sql/init_db.sql
├── submit.php
├── terraform.tfvars
├── terraform.tfvars.example
└── variables.tf
```

---

## 🔁 Workflow

```text
Internet → Load Balancer → Web Server → App Server → RDS (MySQL)
```

- Web server (Nginx) serves form
- App server (PHP) handles submission
- RDS stores the data
- Bastion host allows Ansible to run on private servers

---

## 🧪 Deliverables

- ✅ Modular Terraform code
- ✅ Ansible playbooks
- ✅ Architecture diagram *(add screenshot)*
- ✅ All code on GitHub
- ✅ Working demo or screenshots *(optional)*
- ✅ This README

---

## 📋 Prerequisites

- AWS CLI configured
- Terraform installed
- Ansible installed
- SSH Key pair created and path updated in `terraform.tfvars`

---

## 🧹 Destroy All Resources

```bash
chmod +x clean.sh
./clean.sh
```

---

## 👨‍💻 Author

**Shaikh Sakib**  
Cloud & DevOps Intern  
Building real infrastructure the real way 🚀

---

## 📜 License

MIT License — Free to use, contribute, and extend.
