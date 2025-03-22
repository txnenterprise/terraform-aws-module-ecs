output "task_definition_arn" {
  value = aws_ecs_task_definition.this.arn
}

output "service_name" {
  value = aws_ecs_service.service.name
}

output "app_url" {
  value = var.app_url
}