terraform {
  backend "s3" {
    region  = "eu-west-2"
    bucket  = "codesmithy-terraform-state-store"
    key     = "codesmithy.tfstate"
    encrypt = true
  }
}
