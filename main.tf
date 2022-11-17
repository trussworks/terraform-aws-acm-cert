data "aws_route53_zone" "main" {
  name = var.zone_name
}

resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "main" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  zone_id = data.aws_route53_zone.main.id
  ttl     = "60"
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}

resource "aws_lb_listener_certificate" "main" {
  count = var.alb_listener_arn != "" ? 1 : 0

  listener_arn    = var.alb_listener_arn
  certificate_arn = aws_acm_certificate.main.arn

  depends_on = [aws_acm_certificate_validation.main]
}

# https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-caa.html
resource "aws_route53_record" "caa" {
  count   = length(var.caa_records) > 0 ? 1 : 0
  zone_id = data.aws_route53_zone.main.id
  name    = var.domain_name
  type    = "CAA"
  records = var.caa_records
  ttl     = "60"
}
