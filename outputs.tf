output "rds_endpoint" {
  value       = module.db.db_endpoint
  description = "RDS endpoint for database connection"
}
output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}
