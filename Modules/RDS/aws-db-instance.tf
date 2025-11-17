
#Retrive secrets from secret manager
data "aws_secretsmanager_secret" "secrets_carrental_db" {
  arn = "arn:aws:secretsmanager:eu-west-3:265766434062:secret:staging/carrental-db-secret-WcjRhu"

}

data "aws_secretsmanager_secret_version" "secrets_carrental_db" {
  secret_id = data.aws_secretsmanager_secret.secrets_carrental_db.id
}

#Instaciate RDS
resource "aws_db_instance" "RDS" {
  allocated_storage       = var.allocated_storage
  db_name                 = var.db_name
  engine                  = var.engine
  instance_class          = "db.t3.micro"
  username                = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.secrets_carrental_db.secret_string))["TEST_USER"]
  password                = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.secrets_carrental_db.secret_string))["TEST_PASS"]
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.db_security_group.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  depends_on = [data.aws_secretsmanager_secret.secrets_carrental_db, data.aws_secretsmanager_secret_version.secrets_carrental_db ]

}