resource "aws_lb_target_group" "this" {
  name        = "${local.prefix_name}-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.this.id
  target_type = "instance"

  health_check {
    path                = var.health_check_path
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 5
  }

  tags = local.common_tags
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    host_header {
      values = [var.app_url]
    }
  }

  dynamic "condition" {
    for_each = var.app_url_path != "" && var.app_url_path != null ? [1] : []
    content {
      path_pattern {
        values = [var.app_url_path]
      }
    }
  }
}