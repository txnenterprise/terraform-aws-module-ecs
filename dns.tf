resource "aws_route53_record" "dns" {
  zone_id = var.route53_zone_id
  name    = var.app_url
  type    = "CNAME"
  ttl     = 60
  records = [var.alb_cname]
}