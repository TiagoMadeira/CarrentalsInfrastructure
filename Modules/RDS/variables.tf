
variable "db_name" {
    description = "the friendly name you want to provide the RDS instance in AWS"
}

variable "engine" {
    description = "the friendly name you want to provide the RDS instance in AWS"
}

variable "vpc_id" {
    description = "Id of the VPC"
}

variable "subnet_private_zone1_id" {
    description = "id of subnet private zone1"
}

variable "subnet_private_zone2_id" {
    description = "id of subnet private zone2"
}

variable "allocated_storage" {
    description = "size in gigabytes of allocated storage"
    type = number
    default = 20
}