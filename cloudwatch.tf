resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.prefix_name}"
  retention_in_days = 7
  tags              = local.common_tags
}