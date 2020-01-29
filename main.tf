/**
 * Creates a TLS certificate using AWS ACM for domains hosted on Route53.
 * The ACM certificate can also be attached to an ALB listener.
 *
 * Creates the following resources:
 *
 * * ACM certificate
 * * Route53 record used to validate TLS certificate
 * * Optional association with an ALB listener
 *
 * ## Usage
 *
 * ```hcl
 * module "acm_cert" {
 *   source = "../../modules/aws-acm-cert"
 *
 *   alb_listener_arn = "arn:aws:elasticloadbalancing:us-west-2:..."
 *   domain_name      = "www.example.com"
 *   zone_name        = "example.com"
 * }
 * ```
 */

data "aws_route53_zone" "main" {
  name = "${var.zone_name}"
}

resource "aws_acm_certificate" "main" {
  domain_name       = "${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name        = "${var.domain_name}"
    Environment = "${var.environment}"
    Automation  = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "main" {
  zone_id = "${data.aws_route53_zone.main.id}"
  name    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.main.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.main.domain_validation_options.0.resource_record_value}"]
  ttl     = "60"
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = "${aws_acm_certificate.main.arn}"
  validation_record_fqdns = ["${aws_route53_record.main.*.fqdn}"]
}

resource "aws_lb_listener_certificate" "main" {
  count = "${var.alb_listener_arn != "" ? 1 : 0}"

  listener_arn    = "${var.alb_listener_arn}"
  certificate_arn = "${aws_acm_certificate.main.arn}"

  depends_on = ["aws_acm_certificate_validation.main"]
}

# https://docs.aws.amazon.com/acm/latest/userguide/troubleshooting-caa.html
resource "aws_route53_record" "caa" {
  count   = "${length(var.caa_records) > 0 ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.main.id}"
  name    = "${var.domain_name}"
  type    = "CAA"
  records = "${var.caa_records}"
  ttl     = "60"
}
