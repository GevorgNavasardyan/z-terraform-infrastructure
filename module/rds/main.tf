resource "random_password" "db_password" {
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "aws_secretsmanager_secret" "db_password" {
  name                    = "${var.rds_db_instance_identifier}-password-${random_id.secret_suffix.hex}"
  description             = "RDS database password"
  recovery_window_in_days = 0

  tags = merge(var.tags, {
    Name = "${var.rds_db_instance_identifier}-password"
  })
}

resource "random_id" "secret_suffix" {
  byte_length = 4
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({
    username = var.db_username
    password = random_password.db_password.result
  })
}

resource "aws_db_subnet_group" "rds" {
  name       = var.aws_db_subnet_group
  subnet_ids = var.private_subnet_id

  tags = merge(var.tags, {
    Name = var.aws_db_subnet_group
  })
}

resource "aws_security_group" "rds" {
  name   = var.rds_aws_security_group
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
    description = "MySQL/Aurora access from VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = merge(var.tags, {
    Name = var.rds_aws_security_group
  })
}

resource "aws_db_instance" "rds" {
  identifier = var.rds_db_instance_identifier

  engine         = var.rds_db_instance_engine
  engine_version = var.rds_db_instance_engine_version
  instance_class = var.rds_db_instance_instance_class

  allocated_storage     = var.rds_db_instance_allocated_storage
  max_allocated_storage = var.rds_db_instance_max_allocated_storage
  storage_type          = var.rds_db_instance_storage_type
  storage_encrypted     = true

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_password.result

  db_subnet_group_name         = aws_db_subnet_group.rds.name
  vpc_security_group_ids       = [aws_security_group.rds.id]
  skip_final_snapshot          = var.skip_final_snapshot
  final_snapshot_identifier    = var.skip_final_snapshot ? null : "${var.rds_db_instance_identifier}-final-snapshot-${formatdate("YYYY-MM-DD-hhmm", timestamp())}"
  publicly_accessible          = false
  backup_retention_period      = var.backup_retention_period
  backup_window                = var.backup_window
  maintenance_window           = var.maintenance_window
  performance_insights_enabled = false
  monitoring_interval          = 0
  deletion_protection          = var.deletion_protection

  tags = merge(var.tags, {
    Name = var.rds_db_instance_identifier
  })
}
