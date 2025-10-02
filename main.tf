terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

module "eks_cluster" {
    source = ".//cluster_module"

  # Input Variables
    enviorment       = "staging"
    region           = "eu-west-3"
    zone1            = "eu-west-3a"
    zone2            = "eu-west-3b"
    eks_name        = "carrental-cluster"
    eks_version      = "1.33"
}