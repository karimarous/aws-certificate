module "example_certificate" {
  source = "./module/aws-acm-issued"
  domain_name = var.domain_name
  private_zone = var.private_zone
  wildcard = var.wildcard
}
