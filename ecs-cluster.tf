resource "aws_ecs_cluster" "ecs_cluster" {
  name = "smartfleet-cluster-frontend"
  tags = var.common_tags
}