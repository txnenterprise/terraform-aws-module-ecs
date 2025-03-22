resource "aws_ecs_task_definition" "this" {
  family                   = "td-${local.prefix_name}"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = [
    jsonencode({
      name  = "app"
      image = var.image
      portMappings = [
        {
          containerPort = var.app_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.this.name
          "awslogs-stream-prefix" = "ecs"
        }
      }
      essential = true
  })]
  tags = local.common_tags
}