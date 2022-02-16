//Enviroment VPC
resource "aws_vpc" "env-vpc" {
  cidr_block = var.vpc
  enable_dns_hostnames = true  
  enable_dns_support   = true
}
//Subnets
resource "aws_subnet" "public-sub-1" {
  vpc_id     = aws_vpc.env-vpc.id
  cidr_block = var.pub1
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Public Subnet 1"
  }
}
resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public-sub-1.id 
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.env-vpc.id
  cidr_block = var.pub2
  availability_zone = "eu-west-1b"

  tags = {
    Name = "Public Subnet 2"
  }
}
resource "aws_route_table_association" "public_2_rt_a" {
  subnet_id      = aws_subnet.public-sub-2.id 
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_subnet" "private-sub-1" {
  vpc_id     = aws_vpc.env-vpc.id
  cidr_block = var.priv1
  availability_zone = "eu-west-1a"

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_db_subnet_group" "data-sub-1" {  
  name       = "data-sub-1"  
  subnet_ids = [aws_subnet.public-sub-1.id, aws_subnet.public-sub-2.id]

  tags = {    
    Name = "Data Subnet Group 1"  }
  }

//Gateways
resource "aws_internet_gateway" "int_gw" {
  vpc_id = aws_vpc.env-vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}
//Route Tables
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.env-vpc.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.int_gw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}