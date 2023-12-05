Creates a TLS certificate using AWS ACM for domains hosted on Route53.
The ACM certificate can also be attached to an ALB listener.

Creates the following resources:

- ACM certificate
- Route53 record used to validate TLS certificate
- Optional association with an ALB listener

## Usage

```hcl
module "acm_cert" {
  source = "trussworks/acm-cert/aws"

  alb_listener_arn = "arn:aws:elasticloadbalancing:us-west-2:..."
  domain_name      = "www.example.com"
  zone_name        = "example.com"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_lb_listener_certificate.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_route53_record.caa](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_listener\_arn | Associate ACM certificate to an ALB listener. | `string` | `""` | no |
| caa\_records | Add CAA records to route53. | `list(string)` | `[]` | no |
| domain\_name | Domain name to associate with the ACM certificate. | `string` | n/a | yes |
| environment | Environment tag. e.g. prod | `string` | n/a | yes |
| tags | Tags to be attached to the ACM certificate. | `map(string)` | `{}` | no |
| zone\_id | The Route53 zone id for which the certificate should be verified and issued. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm\_arn | The ARN of the validated ACM certificate. |
<!-- END_TF_DOCS -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```
