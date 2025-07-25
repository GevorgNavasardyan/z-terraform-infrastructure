variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "main_vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_public_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "subnet_public_availability_zone" {
  description = "Availability zones for public subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "public_subnet_name" {
  description = "Name for public subnet"
  type        = string
  default     = "public_subnet"
}

variable "private_subnet_name" {
  description = "Base name for private subnets"
  type        = string
  default     = "private_subnet"
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_availability_zone" {
  description = "Availability zones for private subnets"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "internet_gateway" {
  description = "Name for internet gateway"
  type        = string
  default     = "main-igw"
}

variable "nat_ip" {
  description = "Name for NAT gateway IP"
  type        = string
  default     = "nat-ip"
}

variable "nat_gateway" {
  description = "Name for NAT gateway"
  type        = string
  default     = "nat_gateway"
}

variable "public_route_table" {
  description = "Name for public route table"
  type        = string
  default     = "public_route_table"
}

variable "private_route_table" {
  description = "Name for private route table"
  type        = string
  default     = "private-route-table"
}
