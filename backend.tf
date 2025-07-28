
terraform {
  backend "s3" {
    bucket = "gev-tfstate-bucket2"
    key    = "zylio/terraform.tfstate"
    region = "eu-central-1"
  }
}
