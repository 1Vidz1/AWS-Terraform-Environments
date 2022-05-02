module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = var.vpc_cidr

  azs             = ["${local.region}a", "${local.region}b"]
  private_subnets = var.priv_subnets
  public_subnets  = var.pub_subnets
  
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