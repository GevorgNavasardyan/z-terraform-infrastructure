resource "aws_ecr_repository" "main" {
  name = var.repository_name

  tags = merge(var.tags, {
    Name = var.repository_name
  })
}
