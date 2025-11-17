resource "aws_security_group" "db_security_group" {
    name            = "db_security_group"
    description     = "enable http access on port 5432"
    vpc_id          =  var.vpc_id

    #allow access within the VPC
    ingress {
        description     = "postgresql access"
        from_port       = 5432
        to_port         = 5432
        protocol        = "tcp"
        cidr_blocks     = ["10.0.0.0/16"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "db security group"
    }
}

resource "aws_db_subnet_group" "database_subnet_group" {
    name            = "database-subnets"
    subnet_ids      = [var.subnet_private_zone1_id,var.subnet_private_zone2_id]
    description     = "Subnets for db instance"

}