variable "region" {
    type = string
    description = "AWS Region"
    //default = "eu-west-1"
}
variable "vpc_cidr" {
    type = string
    description = "VPC CIDR"
}
variable "pub_subnets" {
  type    = list(string)
  description = "Public subnets CIDR"
}
variable "priv_subnets" {
  type    = list(string)
  description = "Private subnets CIDR"
}
