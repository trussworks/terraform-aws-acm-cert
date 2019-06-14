<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Creates a TLS certificate using AWS ACM for domains hosted on Route53.
The ACM certificate can also be attached to an ALB listener.

Creates the following resources:

* ACM certificate
* Route53 record used to validate TLS certificate
* Optional association with an ALB listener

## Usage

```hcl
module "acm_cert" {
  source = "../../modules/aws-acm-cert"

  alb_listener_arn = "arn:aws:elasticloadbalancing:us-west-2:..."
  domain_name      = "www.example.com"
  zone_name        = "example.com"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_listener\_arn | (Optional) Associate ACM certificate to and ALB listener. | string | `""` | no |
| caa\_records | Add CAA records to route53. | list | `[]` | no |
| domain\_name | Domain name to associate with the ACM certificate. | string | n/a | yes |
| environment | Environment tag. | string | n/a | yes |
| zone\_name | The Route53 zone name for which the certificate should be verified and issued. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm\_arn | The ARN of the validated ACM certificate. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
