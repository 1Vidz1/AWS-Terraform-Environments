module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = "10.10.0.0/16"

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24","10.10.4.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]

  enable_dns_hostnames = true
  enable_dns_support   = true
  create_igw           = true 
  enable_nat_gateway   = false

  tags = {
    Terraform = "true"
    Environment = "HV"
  }
}

resource "aws_eip" "nat_gw_pub_1" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_pub_1" {
  allocation_id = aws_eip.nat_gw_pub_1.id 
  subnet_id     = "${element(module.vpc.public_subnets, 0)}"

  tags = {
    Name = "gw NAT A"
  }
}

resource "aws_eip" "nat_gw_pub_2" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gw_pub_2" {
  allocation_id = aws_eip.nat_gw_pub_2.id 
  subnet_id     = "${element(module.vpc.public_subnets, 1)}"

  tags = {
    Name = "gw NAT B"
  }
} 