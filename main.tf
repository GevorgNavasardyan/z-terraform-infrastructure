data "aws_caller_identity" "current" {}

module "vpc" {
  source                           = "./module/vpc"
  tags                             = local.tags
  vpc_name                         = "${local.workspace.environment}-${local.project_name}-vpc"
  vpc_cidr                         = local.workspace.cidr
  subnet_public_cidr               = local.workspace.subnet_public_cidr
  public_subnet_name               = "${local.workspace.environment}-${local.project_name}-public_subnet"
  private_subnet_availability_zone = local.workspace.private_subnet_availability_zone
  private_subnet_cidr              = local.workspace.private_subnet_cidr
  private_subnet_name              = "${local.workspace.environment}-${local.project_name}-private_subnet"
  internet_gateway                 = "${local.workspace.environment}-${local.project_name}-internet_gateway"
  nat_gateway                      = "${local.workspace.environment}-${local.project_name}-nat_gateway"
  public_route_table               = "${local.workspace.environment}-${local.project_name}-public_route_table"
  private_route_table              = "${local.workspace.environment}-${local.project_name}-private_route_table"
  nat_ip                           = "${local.workspace.environment}-${local.project_name}-nat_ip"
}

module "rds" {
  source                            = "./module/rds"
  tags                              = local.tags
  vpc_id                            = module.vpc.vpc_id
  vpc_cidr                          = module.vpc.vpc_cidr
  private_subnet_id                 = module.vpc.private_subnet_id
  db_name                           = local.workspace.db_name
  aws_db_subnet_group               = "${local.workspace.environment}-${local.project_name}-rds-subnet-group"
  rds_aws_security_group            = "${local.workspace.environment}-${local.project_name}-rds-sg"
  rds_db_instance_identifier        = "${local.workspace.environment}-${local.project_name}-rds"
  rds_db_instance_engine            = local.workspace.rds_db_instance_engine
  rds_db_instance_instance_class    = local.workspace.rds_db_instance_instance_class
  rds_db_instance_allocated_storage = local.workspace.rds_db_instance_allocated_storage
  skip_final_snapshot               = true
  deletion_protection               = false
}


module "ecr" {
  source          = "./module/ecr"
  repository_name = "${local.workspace.environment}-${local.project_name}-app"
  tags            = local.tags
}

module "alb" {
  source                  = "./module/alb"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_ids       = module.vpc.public_subnet_id
  alb_name                = "${local.workspace.environment}-${local.project_name}-alb"
  alb_security_group_name = "${local.workspace.environment}-${local.project_name}-alb-sg"
  target_group_name       = "${local.workspace.environment}-${local.project_name}-tg"
  target_port             = local.workspace.container_definitions_containerPort
  tags                    = local.tags
}

module "ecs" {
  source                  = "./module/ecs"
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_id
  cluster_name            = "${local.workspace.environment}-${local.project_name}-cluster"
  service_name            = "${local.workspace.environment}-${local.project_name}-service"
  task_family             = local.workspace.ecs_task_definition_family
  container_name          = local.workspace.container_definitions_name
  container_image         = local.workspace.container_definitions_image
  container_port          = local.workspace.container_definitions_containerPort
  task_memory             = local.workspace.container_definitions_memory
  ecs_security_group_name = "${local.workspace.environment}-${local.project_name}-ecs-sg"
  alb_security_group_id   = module.alb.alb_security_group_id
  target_group_arn        = module.alb.target_group_arn
  tags                    = local.tags
}

output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.db_endpoint
  sensitive   = true
}

output "rds_secret_name" {
  description = "Name of the secret containing RDS password"
  value       = module.rds.db_password_secret_name
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = module.ecs.cluster_name
}
