resource "aws_ecr_repository" "repo_ecr" {
  name                 = "smartfleet-frontend"
  image_tag_mutability = "MUTABLE"

  tags = var.common_tags
}