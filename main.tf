module "vpc" {
  source = "./vpc"

  client_name = "codesmithy"
  cidr_block  = "10.0.0.0/16"
  public_subnet_cidr_blocks = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
}

module "website" {
  source = "./website"

  client_name = "codesmithy"
  domain_urls = [
    "thecodesmithy.com",
    "thecodesmithy.co.uk"
  ]
  mx_records = [
    "aspmx.l.google.com.",
    "alt1.aspmx.l.google.com.",
    "alt2.aspmx.l.google.com.",
    "alt3.aspmx.l.google.com.",
    "alt4.aspmx.l.google.com.",
  ]
  txt_records = [
    "google-site-verification=Al2AdKVi9MT3EAh36sf7Ve8F2oE4wKjPgP3dc-Oi394",
  ]

  providers = {
    aws           = aws
    aws.us-east-1 = aws.us-east-1
  }
}

