#tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "ecs_sg" {
  name        = "${local.prefix_name}-ecs-sg"
  description = "Security group for ECS Fargate service"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "HTTP ingress"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.this.cidr_block]
  }

  egress {
    description = "Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}