
# 🚀 Fully Automated 3-Tier AWS Infrastructure with Terraform & Ansible

## 🎯 Objective  
Provision a **fully automated 3-tier architecture on AWS** using **Terraform** for infrastructure and **Ansible** for server configuration. Everything is orchestrated via the `deploy.sh` script—no manual interventions needed.

---

## 🧠 Project Architecture

```
Internet → ALB → Web EC2 → App EC2 → RDS (MySQL)
              ↑                ↑
           Terraform         Ansible
```

- **Application Load Balancer** – Handles incoming HTTP traffic.
- **Web Tier** (Public subnet) – Serves `forms.html` via Nginx.
- **App Tier** (Private subnet) – Handles form submissions with PHP (`submit.php`).
- **Database Tier** (Private subnet) – Amazon RDS MySQL instance stores user data.
- **Bastion Host** – Enables Ansible access to private-tier servers.

---

## 🏗️ Infrastructure Overview
Terraform modules provision:

- **VPC**: Public + private subnets (in 2 AZs), IGW, NATs, route tables, SGs  
- **Web EC2**: Nginx, static form  
- **App EC2**: PHP, MySQL client, Nginx + PHP-FPM config  
- **RDS**: Private MySQL instance, secured access  
- **Security Groups**: Restriction per tier  
- **Bastion**: SSH jump host for Ansible

Ansible performs:
- Package installs (PHP, Nginx, MySQL client)  
- Code deployment (`forms.html`, `submit.php`)  
- PHP-FPM config including environment variables  
- SQL script execution (`init_db.sql`) to initialize `facebook` DB and `users` table

---

## 🚀 Deployment Instructions

### Prerequisites

Ensure installed and configured:
- **AWS CLI** (with proper IAM credentials)
- **Terraform** (v1.0+)
- **Ansible** (v2.10+)
- Executable permissions for scripts:
  ```bash
  chmod +x deploy.sh clean.sh
  ```

### Step-by-step Deployment

1. Clone repo:
   ```bash
   git clone https://github.com/Sohel-222/terraform-3tier-aws-architecture.git
   cd terraform-3tier-aws-architecture
   ```

2. Launch deployment:
   ```bash
   ./deploy.sh
   ```

This script will:
- Initialize Terraform, plan, and apply infrastructure
- Use the bastion host to run Ansible against EC2 instances
- Configure Nginx, PHP, environment variables, and initialize the MySQL database (`facebook.users`)

---

## 📦 Repository Structure

```
.
├── ansible/
│   ├── app-setup.yml
│   ├── web-setup.yml
│   └── hosts.ini
├── forms.html
├── submit.php
├── sql/init_db.sql
├── deploy.sh
├── clean.sh
├── terraform.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
└── modules/
    ├── vpc/
    ├── sg/
    ├── bastion/
    ├── web/
    ├── app/
    └── rds/
```

---

## 🔧 What Happens at Runtime

- `deploy.sh` runs Terraform to provision all AWS resources
- Once EC2 instances are up, Ansible playbooks configure them:
  - **Web Tier**: sets up Nginx and hosts `forms.html`
  - **App Tier**: installs PHP-FPM, deploys `submit.php`, configures environment variables via `/etc/php/8.3/fpm/pool.d/www.conf`, runs `/tmp/init_db.sql`
- Result: submitting the form stores data in RDS MySQL database named `facebook`

---

## 📽️ Demo Video

▶️ [Watch Project_Execution.mp4](./project_ss-video/Project_Execution.mp4)

---

## 🧪 Deliverables

- ✅ Modular Terraform code (with reusable modules)
- ✅ Ansible playbooks for full automation
- ✅ Custom VPC with multi-AZ subnets
- ✅ Configured Bastion Host for private access
- ✅ Dynamic infrastructure provisioning (`deploy.sh`)
- ✅ RDS initialization with database + tables
- ✅ Screenshots and demo video
- ✅ Full documentation (this README)

---

## 🧹 Tear Down Resources

To clean everything:

```bash
./clean.sh
```

This runs `terraform destroy`, removing all created AWS resources.

---

## 👤 Author

**Sohel Shaikh** — Cloud & DevOps Intern  
_Turning code into real-world infrastructure 🚀_  

---

## 📜 License

MIT — Feel free to use, modify, and contribute!
