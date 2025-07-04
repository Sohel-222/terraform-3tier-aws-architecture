terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.myregion
}

#Key-pair

resource "aws_key_pair" "tf-key-pair" {
  key_name   = "NayaWala"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "NayaWala"
}

resource "aws_lb_target_group_attachment" "internet_TG_EC2" {
  target_group_arn = module.vpc.internet_tg_arn  # output from vpc module
  target_id        = module.web.web_instance_id  # output from web module
  port             = 80
}

module "security" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source    = "./modules/vpc"
  alb_sg_id = module.security.alb_sg_id
}

module "web" {
  source        = "./modules/web"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  vpc_sg_id     = module.security.web_sg_id
  subnet_id     = module.vpc.websubnet_id
}

module "app" {
  source        = "./modules/app"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  vpc_sg_id     = module.security.app_sg_id
  subnet_id     = module.vpc.appsubnet_id
}

module "db" {
  source         = "./modules/rds"
  vpc_sg_id      = module.security.db_sg_id
  dbsubnet_group = module.vpc.dbsubnet_group
  rds_endpoint   = module.db.db_endpoint
  username       = var.username
  password       = var.password
}

# Local .env file for Ansible (with DB creds)
resource "local_file" "db_env_file" {
  content  = <<EOT
DB_HOST=${module.db.db_endpoint}
DB_USER=${var.username}
DB_PASS=${var.password}
DB_NAME=mydb
EOT
  filename = "${path.module}/ansible/db_env.sh"
}
