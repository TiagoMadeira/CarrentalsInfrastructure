variable "environment" {
  description = "The enviorment we are in"
  type        = string
  default     = "staging"
}

#Cluster variables
variable "eks_name" {
  description = "Name of the cluster"
  type        = string
  default     = "staging"
}

variable "eks_version" {
  description = "Version of kubernetes"
  type        = string
  default     = "staging"
}

variable "vpc_id" {
    description = "Id of the VPC"
}

variable "subnet_private_zone1_id" {
  description = "Private zone1 id"
  type        = string
}

variable "subnet_private_zone2_id" {
  description = "Private zone2 id"
  type        = string
}
