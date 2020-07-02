resource "aws_acm_certificate" "this" {
  count = length(var.domain_urls)

  provider = aws.us-east-1

  domain_name               = var.domain_urls[count.index]
  subject_alternative_names = ["*.${var.domain_urls[count.index]}"]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  count = length(var.domain_urls)

  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this[count.index].arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation[count.index].fqdn
  ]
}

resource "aws_route53_record" "cert_validation" {
  count = length(var.domain_urls)

  name    = aws_acm_certificate.this[count.index].domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.this[count.index].domain_validation_options.0.resource_record_type
  zone_id = aws_route53_zone.this[count.index].zone_id
  ttl     = 60

  records = [
    aws_acm_certificate.this[count.index].domain_validation_options.0.resource_record_value
  ]
}

