# 🚀 Fully Automated 3-Tier AWS Infrastructure with Terraform & Ansible

> ⚡ No manual steps required — everything is **100% automated**!
---

## 🎯 Objective

This project provisions a complete **3-tier architecture on AWS** using **Terraform** and configures it automatically using **Ansible** — all triggered by a single script: `deploy.sh`.

---

## 🧠 Project Overview

This is a **3-tier cloud architecture** consisting of:

- **Load Balancer** → Handles external traffic  
- **Web Tier** → Serves `forms.html` via Nginx  
- **App Tier** → Processes form data using `submit.php`  
- **Database Tier (RDS)** → Stores data in MySQL  
- **Bastion Host** → Enables secure access to private subnets for Ansible

All of this is deployed inside a custom **VPC** for better security and control.

---

## 🔄 Deployment Flow

```text
Internet → Load Balancer → Web Server → App Server → RDS (MySQL)
```

- **User sends request** → Hits **Load Balancer**  
- **Web Server (Nginx)** → Serves the form  
- **App Server (PHP)** → Accepts form data, sends to **RDS**  
- **RDS (MySQL)** → Stores data securely

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
│   ├── app
│   │   ├── main.tf
│   │   └── variable.tf
│   ├── bastion
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── rds
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── sg
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variable.tf
│   ├── vpc
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   └── web
│       ├── main.tf
│       └── variables.tf
├── outputs.tf
├── sql
│   └── init_db.sql
├── submit.php
├── terraform.tfvars
└── variables.tf
```

---

## 🛠️ Prerequisites

- AWS CLI configured with appropriate IAM credentials  
- Terraform (v1.0+)  
- Ansible (v2.10+)

---

## ⚙️ Technologies Used

- **Terraform** – Infrastructure as Code  
- **Ansible** – Server Configuration  
- **AWS** – VPC, EC2, RDS, Load Balancer  
- **Ubuntu, Nginx, PHP, MySQL** – Web and App Stack

---

## 🧪 Deliverables

- ✅ Modular Terraform code
- ✅ Ansible playbooks
- ✅ Architecture diagram *(add screenshot)*
- ✅ All code on GitHub
- ✅ Working demo or screenshots *(optional)*
- ✅ This README

---

## 🧹 Destroy All Resources

```bash
chmod +x clean.sh
./clean.sh
```

---

## 👨‍💻 Author

**Sohel Shaikh**  
Cloud & DevOps Intern  
Building real infrastructure the real way 🚀

---

## 📜 License

MIT License — Free to use, contribute, and extend.
