provider "aws" {
    region = "eu-west-1"
}

locals {
  name   = "hv-aws"
  region = "eu-west-1"
  tags = {
    Owner       = "avidigal"
    Environment = "High Availability Env"
    Name        = "HV-AWS Env"
  }
}
