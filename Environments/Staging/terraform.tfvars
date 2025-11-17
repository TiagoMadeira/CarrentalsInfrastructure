#Networking variables
environment                     = "staging"
vpc_region                      = "eu-west-3"     
zone1                           = "eu-west-3a"
zone2                           = "eu-west-3c"
#eks varibales
eks_name                        = "carrental-cluster"
eks_version                     = "1.33"
eks_instances_type              = "t3.small"
#Database variables
database_name                   = "StagingCarrentalDb"
database_engine                 = "postgres"
database_allocated_storage      = 20

#Api variables
api_gateway_integration_uri     = "arn:aws:elasticloadbalancing:eu-west-3:265766434062:listener/net/k8s-ingress-external-877e342152/7bee3851aaf2a1be/49b65f2be3503a7a"
