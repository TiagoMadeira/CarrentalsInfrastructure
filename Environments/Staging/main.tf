terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "3.0.2"
    }
  }
}

provider "helm" {
  kubernetes = {
    config_path = "C:/Users/Tiago/.kube/config"
  }
}

provider "aws" {
  region = "eu-west-3"
}

module "networking"{
  source = "./../../Modules/networking"

    environment      = "staging"
    region           = "eu-west-3"
    zone1            = "eu-west-3a"
    zone2            = "eu-west-3c"

}


module "eks_cluster" {
    source = "./../../Modules/EKS_cluster"

  # Input Variables
    environment               = "staging"
    eks_name                  = "carrental-cluster"
    eks_version               = "1.33"
    vpc_id                    = module.networking.vpc_id
    subnet_private_zone1_id   = module.networking.subnet_private_zone1_id
    subnet_private_zone2_id   = module.networking.subnet_private_zone2_id

    depends_on = [ module.networking ]
}


module "rds_db" {
   source = "./../../Modules/RDS"

   db_name                    = "StagingCarrentalDb"
   engine                     = "postgres"
   vpc_id                     = module.networking.vpc_id
   subnet_private_zone1_id    = module.networking.subnet_private_zone1_id
   subnet_private_zone2_id    = module.networking.subnet_private_zone2_id

   depends_on = [ module.networking ]
}


module "api_gateway" {
  source = "./../../Modules/APIgateway"

  vpc_id                      = module.networking.vpc_id
  subnet_private_zone1_id     = module.networking.subnet_private_zone1_id
  subnet_private_zone2_id     = module.networking.subnet_private_zone2_id
}

output "signup_url" {
  value = module.api_gateway.signup_url
}
