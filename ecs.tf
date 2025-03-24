resource "aws_ecs_service" "service" {
  name                               = "${local.prefix_name}-service"
  cluster                            = var.ecs_cluster_id
  task_definition                    = aws_ecs_task_definition.this.id
  deployment_minimum_healthy_percent = "100"
  deployment_maximum_percent         = "200"
  desired_count                      = "1"
  launch_type                        = "EC2"
  scheduling_strategy                = "REPLICA"

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider
    weight            = 100
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "app"
    container_port   = var.app_port
  }

  tags = local.common_tags

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }
}