resource "aws_kms_key" "acw" {
  description             = "KMS Key ${local.prefix_name}"
  deletion_window_in_days = 15
  enable_key_rotation     = true
  tags                    = local.common_tags
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.prefix_name}"
  retention_in_days = 7
  kms_key_id        = aws_kms_key.acw.id
  tags              = local.common_tags
}