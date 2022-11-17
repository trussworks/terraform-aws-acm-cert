locals {
  zone_name   = "infra-test.truss.coffee"
  environment = "test"
}

module "acm-cert" {
  source = "../.."

  domain_name = "${var.test_name}.${local.zone_name}"
  environment = local.environment
  zone_name   = local.zone_name
}
