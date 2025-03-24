resource "aws_ecr_repository" "this" {
  name = "txn-enterprise/${var.environment}/${var.project}"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.common_tags
}