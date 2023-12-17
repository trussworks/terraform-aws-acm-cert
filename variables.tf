variable "alb_listener_arn" {
  type        = string
  description = "Associate ACM certificate to an ALB listener."
  default     = ""
}

variable "caa_records" {
  description = "Add CAA records to route53."
  type        = list(string)
  default     = []
}

variable "domain_name" {
  type        = string
  description = "Domain name to associate with the ACM certificate."
}

variable "environment" {
  type        = string
  description = "Environment tag. e.g. prod"
}

variable "tags" {
  description = "Tags to be attached to the ACM certificate."
  type        = map(string)
  default     = {}
}

variable "zone_id" {
  type        = string
  description = "The Route53 zone id for which the certificate should be verified and issued."
}
