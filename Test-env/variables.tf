variable "vpc" {
    type = string
    description = "Env-VPC"
}
variable "pub1" {
    type = string
    description = "Public Subnet 1"
}
variable "priv1" {
    type = string
    description = "Private Subnet 1"
}
variable "enviroment" {
    type = string
    description = "description of this var"
    default = "default env"
}
variable "instance_type"{
    type = string
    description = "size of the server"
}
variable "keypair"{
    type = string
    description = "SSH key"
}