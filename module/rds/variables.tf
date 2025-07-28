variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block for security group rules"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "private_subnet_id" {
  description = "Private subnet IDs for RDS subnet group"
  type        = list(string)
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "aws_db_subnet_group" {
  description = "Name for the DB subnet group"
  type        = string
  default     = "rds-subnet-group"
}

variable "rds_aws_security_group" {
  description = "Name for the RDS security group"
  type        = string
  default     = "rds-sg"
}

variable "rds_db_instance_identifier" {
  description = "RDS instance identifier"
  type        = string
  default     = "rds"
}

variable "rds_db_instance_engine" {
  description = "Database engine"
  type        = string
  default     = "mysql"
}

variable "rds_db_instance_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "8.0"
}

variable "rds_db_instance_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_db_instance_allocated_storage" {
  description = "Initial allocated storage in GB"
  type        = number
  default     = 20
}

variable "rds_db_instance_max_allocated_storage" {
  description = "Maximum allocated storage for autoscaling"
  type        = number
  default     = 100
}

variable "rds_db_instance_storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp2"
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Backup window"
  type        = string
  default     = "03:00-04:00"
}

variable "maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "performance_insights_enabled" {
  description = "Enable Performance Insights"
  type        = bool
  default     = true
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds"
  type        = number
  default     = 60
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}
