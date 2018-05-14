/**
 * Creates a TLS certificate using AWS ACM for domains hosted on Route53.
 *
 * Creates the following resources:
 *
 * * ACM certificate where the Common Name will be the first entry in `domain_names`. All other entries will be Subject Name Alternatives.
 * * Route53 record used to validate TLS certificate
 *
 * ## Usage
 *
 * ```hcl
 * module "acm_cert" {
 *   source = "../../modules/aws-acm-cert"
 *
 *   domain_names = ["example.com", "www.example.com"]
 *   zone_name    = "example.com"
 * }
 * ```
 */

data "aws_route53_zone" "main" {
  name = "${var.zone_name}"
}

resource "aws_acm_certificate" "main" {
  # use the first entry for the domain_name and append the rest as subject alternative names
  domain_name               = "${var.domain_names[0]}"
  validation_method         = "DNS"
  subject_alternative_names = "${slice(var.domain_names, 1, length(var.domain_names))}"

  tags {
    Environment = "${var.environment}"
  }
}

resource "aws_route53_record" "main" {
  count = "${length(var.domain_names)}"

  zone_id = "${data.aws_route53_zone.main.id}"

  name    = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index],"resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.main.domain_validation_options[count.index],"resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.main.domain_validation_options[count.index],"resource_record_value")}"]
  ttl     = "60"
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = "${aws_acm_certificate.main.arn}"
  validation_record_fqdns = ["${aws_route53_record.main.*.fqdn}"]
}
