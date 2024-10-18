data "aws_route53_zone" "example_route53_zone" {
  name         = var.domain_name
  private_zone = var.private
}

resource "aws_acm_certificate" "example_acm_frontend_certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = var.wildcard == true ? ["*.${var.domain_name}"] : ["${var.domain_name}"]
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "example_route53_frontend_records_verification" {
  for_each = {
    for domain_verification_option in aws_acm_certificate.example_acm_frontend_certificate.domain_validation_options : domain_verification_option.domain_name => {
      name   = domain_verification_option.resource_record_name
      record = domain_verification_option.resource_record_value
      type   = domain_verification_option.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.example_route53_zone.id
  depends_on = [ aws_acm_certificate.example_acm_frontend_certificate ]
}

resource "aws_acm_certificate_validation" "talentia_frontend_certificate_validation" {
  certificate_arn         = aws_acm_certificate.example_acm_frontend_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.example_route53_frontend_records_verification : record.fqdn]
  depends_on = [ aws_acm_certificate.example_acm_frontend_certificate, aws_route53_record.example_route53_frontend_records_verification ]
}
