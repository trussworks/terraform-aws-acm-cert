output "acm_arn" {
  description = "The ARN of the validated ACM certificate."
  value       = module.acm-cert.acm_arn
}
