locals {
  region       = "eu-central-1"
  project_name = "zylio"

  workspace = {
    environment                         = "dev"
    cidr                                = "10.0.0.0/16"
    subnet_public_cidr                  = "10.0.1.0/24"
    subnet_public_availability_zone     = ["eu-central-1a", "eu-central-1b"]
    private_subnet_availability_zone    = ["eu-central-1a", "eu-central-1b"]
    private_subnet_cidr                 = ["10.0.2.0/24", "10.0.3.0/24"]
    container_definitions_name          = "nginx"
    container_definitions_image         = "nginx:latest"
    container_definitions_memory        = "512"
    container_definitions_containerPort = 80
    ecs_task_definition_family          = "nginx"
    rds_db_instance_engine              = "mysql"
    rds_db_instance_instance_class      = "db.t3.micro"
    rds_db_instance_allocated_storage   = 20
    db_name                             = "testgev"
  }

  tags = {
    Environment = local.workspace.environment
    Provisioner = "terraform"
    Project     = local.project_name
  }
}
