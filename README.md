Creates a TLS certificate using AWS ACM for domains hosted on Route53.

Creates the following resources:

* ACM certificate where the Common Name will be the first entry in `domain_names`. All other entries will be Subject Name Alternatives.
* Route53 record used to validate TLS certificate

## Usage

```hcl
module "acm_cert" {
  source = "../../modules/aws-acm-cert"

  domain_names = ["example.com", "www.example.com"]
  zone_name    = "example.com"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| domain_names | List of domain names to associate with the ACM certificate. | list | - | yes |
| environment | Environment tag. | string | - | yes |
| zone_name | The Route53 zone name for which the certificate should be verified and issued. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm_arn | The ARN of the validated ACM certificate. |

