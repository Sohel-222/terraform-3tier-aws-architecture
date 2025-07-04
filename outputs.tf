output "rds_endpoint" {
  value       = module.db.db_endpoint
  description = "RDS endpoint for database connection"
}
