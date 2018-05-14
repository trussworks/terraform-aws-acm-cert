variable "domain_names" {
  type        = "list"
  description = "List of domain names to associate with the ACM certificate."
}

variable "environment" {
  type        = "string"
  description = "Environment tag."
}

variable "zone_name" {
  type        = "string"
  description = "The Route53 zone name for which the certificate should be verified and issued."
}
