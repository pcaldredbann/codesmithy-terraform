resource "aws_route53_zone" "this" {
  count = length(var.domain_urls)

  name    = var.domain_urls[count.index]
  comment = var.domain_urls[count.index]
}

resource "aws_route53_record" "ns" {
  count = length(var.domain_urls)

  name    = var.domain_urls[count.index]
  zone_id = aws_route53_zone.this[count.index].zone_id
  type    = "NS"
  ttl     = 3600
  records = [
    aws_route53_zone.this[count.index].name_servers.0,
    aws_route53_zone.this[count.index].name_servers.1,
    aws_route53_zone.this[count.index].name_servers.2,
    aws_route53_zone.this[count.index].name_servers.3
  ]
}

resource "aws_route53_record" "a" {
  count = length(var.domain_urls)

  name    = var.domain_urls[count.index]
  zone_id = aws_route53_zone.this[count.index].zone_id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this[count.index].domain_name
    zone_id                = aws_cloudfront_distribution.this[count.index].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "mx" {
  count = length(var.domain_urls)

  name    = ""
  zone_id = aws_route53_zone.this[count.index].zone_id
  type    = "MX"
  ttl     = 3600

  records = [
    "1 ASPMX.L.GOOGLE.COM",
    "3 ALT1.ASPMX.L.GOOGLE.COM",
    "3 ALT2.ASPMX.L.GOOGLE.COM",
    "5 ASPMX2.GOOGLEMAIL.COM",
    "5 ASPMX3.GOOGLEMAIL.COM",
  ]
}

resource "aws_route53_record" "txt" {
  count = length(var.domain_urls)

  name    = var.domain_urls[count.index]
  zone_id = aws_route53_zone.this[count.index].zone_id
  type    = "TXT"
  records = var.txt_records
  ttl     = 3600
}



