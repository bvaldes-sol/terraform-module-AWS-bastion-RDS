# AWS Region
output "region" {
  value = var.region
}

# Project-app Name
output "project_name" {
  value = var.project_name
}

# Main VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

# Main Internet Gateway
output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}

#Public Subnets ID
output "public_subnet_az1_id" {
  value = aws_subnet.public_subnet_az1.id
}

output "public_subnet_az2_id" {
  value = aws_subnet.public_subnet_az2.id
}

output "public_subnet_az3_id" {
  value = aws_subnet.public_subnet_az3.id
}

# Private Subnets ID
output "private_subnet_az1_id" {
  value = aws_subnet.private_subnet_app_az1.id
}

output "private_subnet_az2_id" {
  value = aws_subnet.private_subnet_app_az2.id
}

output "private_subnet_az3_id" {
  value = aws_subnet.private_subnet_app_az3.id
}

# AWS Database Subnet
output "aws_db_subnet_group_id" {
  value = aws_db_subnet_group.postgres-subnet-group.id
}

