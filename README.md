<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
Creates a TLS certificate using AWS ACM for domains hosted on Route53. ACM certificate can also be attached to an ALB listener.

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
| alb_listener_arn | (Optional) Associate ACM certificate to and ALB listener. | string | `` | no |
| domain_name | Domain name to associate with the ACM certificate. | string | - | yes |
| environment | Environment tag. | string | - | yes |
| zone_name | The Route53 zone name for which the certificate should be verified and issued. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm_arn | The ARN of the validated ACM certificate. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
