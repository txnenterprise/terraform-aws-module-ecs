resource "aws_ecs_task_definition" "this" {
  family                   = "td-${local.prefix_name}"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions =  jsonencode([
    {
      name  = "app"
      image = "${aws_ecr_repository.this.repository_url}:latest"
      portMappings = [
        {
          containerPort = var.app_port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.this.name
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      essential = true
    }
  ])
  lifecycle {
    ignore_changes = all
  }
}