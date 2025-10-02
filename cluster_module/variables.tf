variable "enviorment" {
  description = "The enviorment we are in"
  type        = string
  default     = "staging"
}


#VPC variables
variable "region" {
  description = "Region of the provider and VPC"
  type        = string
  default     = "staging"
}

variable "zone1" {
  description = "First availability zone for the subnets"
  type        = string
  default     = "staging"
}

variable "zone2" {
  description = "Second availability zone for the subnets"
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