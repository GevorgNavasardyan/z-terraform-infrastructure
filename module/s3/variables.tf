variable "bucket_name" {
  description = "gev-tfstate-bucket2"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
