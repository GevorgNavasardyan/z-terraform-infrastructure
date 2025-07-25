variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "alb_name" {
  description = "ALB name"
  type        = string
}

variable "alb_security_group_name" {
  description = "ALB security group name"
  type        = string
}

variable "target_group_name" {
  description = "Target group name"
  type        = string
}

variable "target_port" {
  description = "Target port"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
