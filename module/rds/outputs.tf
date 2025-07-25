output "db_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "db_host" {
  description = "Database host (without port)"
  value       = aws_db_instance.rds.address
}

output "db_port" {
  description = "Database port"
  value       = aws_db_instance.rds.port
}

output "db_name" {
  description = "Database name"
  value       = aws_db_instance.rds.db_name
}

output "db_username" {
  description = "Database username"
  value       = aws_db_instance.rds.username
}

output "db_password_secret_name" {
  description = "Name of the secret containing database password"
  value       = aws_secretsmanager_secret.db_password.name
}
