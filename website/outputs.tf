output "hosting_zone_id" {
  value = aws_route53_zone.this.*.zone_id
}

output "website_endpoint" {
  value = aws_s3_bucket.this.*.website_endpoint
}

output "website_domain" {
  value = aws_s3_bucket.this.*.website_domain
}
