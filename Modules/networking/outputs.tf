output "subnet_private_zone1_id" {
  description = "Private Zone 1 id"
  value       = aws_subnet.private_zone1.id
}

output "subnet_private_zone2_id" {
  description = "Private Zone 2 id"
  value       = aws_subnet.private_zone2.id
}

output "vpc_id" {
  description = "Vpc id"
  value       = aws_vpc.main.id
}

