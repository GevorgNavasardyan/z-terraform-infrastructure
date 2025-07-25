variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "task_family" {
  description = "Task definition family"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "container_image" {
  description = "Container image"
  type        = string
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 80
}

variable "task_cpu" {
  description = "Task CPU"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Task memory"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Desired task count"
  type        = number
  default     = 1
}

variable "ecs_security_group_name" {
  description = "ECS security group name"
  type        = string
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
