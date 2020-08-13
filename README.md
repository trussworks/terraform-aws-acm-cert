Creates a TLS certificate using AWS ACM for domains hosted on Route53.
The ACM certificate can also be attached to an ALB listener.

Creates the following resources:

* ACM certificate
* Route53 record used to validate TLS certificate
* Optional association with an ALB listener

## Terraform Versions

_This is how we're managing the different versions._
Terraform 0.12. Pin module version to ~> 2.0. Submit pull-requests to master branch.

Terraform 0.11. Pin module version to ~> 1.0. Submit pull-requests to terraform011 branch.

## Usage

```hcl
module "acm_cert" {
  source = "../../modules/aws-acm-cert"

  alb_listener_arn = "arn:aws:elasticloadbalancing:us-west-2:..."
  domain_name      = "www.example.com"
  zone_name        = "example.com"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.0 |
| aws | ~> 2.70 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.70 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alb\_listener\_arn | (Optional) Associate ACM certificate to and ALB listener. | `string` | `""` | no |
| caa\_records | Add CAA records to route53. | `list(string)` | `[]` | no |
| domain\_name | Domain name to associate with the ACM certificate. | `string` | n/a | yes |
| environment | Environment tag. e.g. prod | `string` | n/a | yes |
| zone\_name | The Route53 zone name for which the certificate should be verified and issued. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm\_arn | The ARN of the validated ACM certificate. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Developer Setup

Install dependencies (macOS)

```shell
brew install pre-commit go terraform terraform-docs
pre-commit install --install-hooks
```

### Testing

[Terratest](https://github.com/gruntwork-io/terratest) is being used for
automated testing with this module. Tests in the `test` folder can be run
locally by running the following command:

```shell
make test
```

Or with aws-vault:

```shell
AWS_VAULT_KEYCHAIN_NAME=<NAME> aws-vault exec <PROFILE> -- make test
```
