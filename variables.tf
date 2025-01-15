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

variable "zone_id" {
  type        = string
  description = "The Route53 zone id for which the certificate should be verified and issued."
}
