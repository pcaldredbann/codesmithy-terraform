resource "aws_s3_bucket" "this" {
  count = length(var.domain_urls)

  bucket = var.domain_urls[count.index]
  acl    = "public-read"
  policy = <<POLICY
{
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Principal": "*",
      "Resource": [
        "arn:aws:s3:::${var.domain_urls[count.index]}/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
POLICY

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
