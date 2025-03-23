variable "environment" {
  type = string
}

variable "project" {
  type = string
}

variable "owner" {
  type    = string
  default = "terraform"
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/healthz"
}

variable "memory" {
  type = number
}

variable "cpu" {
  type = number
}

variable "app_port" {
  type = number
}

variable "listener_arn" {
  type = string
}

variable "app_url" {
  type = string
}

variable "app_url_path" {
  type    = string
  default = null
}

variable "ecs_cluster_id" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "alb_cname" {
  type = string
}