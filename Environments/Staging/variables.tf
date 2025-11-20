variable "environment" {
    description = "Environment of the infrastructure"
}

variable "vpc_region" {
    description = "aws region of the vpc"
}

variable "zone1" {
    description = "sub zone1 for the creation of a subnet"
}

variable "zone2" {
    description = "sub zone 2 fo the creation of the subnet"
}

variable "eks_name" {
    description = "Name of the eks cluster"
}  

variable "eks_version" {
    description = "version of the eks"
}

variable "eks_instances_type" {
  description = "Instances type of the nodes"
}

variable "database_name" {
    description = "Name of the database"
}

variable "database_engine" {
    description = "Name of the database engine"
}

variable "database_allocated_storage" {
    description = "Name of the database engine"
}

variable "api_gateway_integration_uri" {
    description = "Uri for the api integration"
}

variable "secrets_arn" {
    description = "Secret's arn you wish to give read permissions"
    type        = list(string)
}