module "hv_network" {
      source = "./modules/hv_network"
      
      region = "eu-central-1"
      vpc_cidr = "10.10.0.0/16"
      pub_subnets = [ "10.10.101.0/24", "10.10.102.0/24" ]
      priv_subnets = [ "10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24","10.10.4.0/24" ]
}