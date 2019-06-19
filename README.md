<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alb\_listener\_arn | (Optional) Associate ACM certificate to and ALB listener. | string | `""` | no |
| caa\_records | Add CAA records to route53. | list(string) | `[]` | no |
| domain\_name | Domain name to associate with the ACM certificate. | string | n/a | yes |
| environment | Environment tag. | string | n/a | yes |
| zone\_name | The Route53 zone name for which the certificate should be verified and issued. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm\_arn | The ARN of the validated ACM certificate. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
