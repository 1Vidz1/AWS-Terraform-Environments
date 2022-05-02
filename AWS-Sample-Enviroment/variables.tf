variable "AWS_Region" {
    type = string
    description = "AWS Region"
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
