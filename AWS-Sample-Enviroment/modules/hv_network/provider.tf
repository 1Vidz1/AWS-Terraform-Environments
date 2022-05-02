provider "aws" {
  region = var.region
}
##Change locals!
locals {
  region = var.region
  environment = "AWS Highly Available Environment Sample"
  owner = "André Vidigal"
  name = "HV-AWS Env"
  common_tags = {
    Environment = local.environment
    Owner   = local.owner
    Name    = local.name
  }
}

