# Main VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    name = "${var.project_name}-vpc"
  }
}

# Gather available Availability zones
data "aws_availability_zones" "available_zones" {
  state = "available"
}

# Main Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    name = "${var.project_name}-internet-gateway"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az1_cidr_block
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-public-subnet-az1"
  }
}

resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az2_cidr_block
  availability_zone       = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-public-subnet-az2"
  }
}

resource "aws_subnet" "public_subnet_az3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az3_cidr_block
  availability_zone       = data.aws_availability_zones.available_zones.names[2]
  map_public_ip_on_launch = true

  tags = {
    name = "${var.project_name}-public-subnet-az3"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet_app_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_app_az1_cidr_block
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    name = "${var.project_name}-private-subnet-az1"
  }
}

resource "aws_subnet" "private_subnet_app_az2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_app_az2_cidr_block
  availability_zone = data.aws_availability_zones.available_zones.names[1]

  tags = {
    name = "${var.project_name}-private-subnet-az2"
  }
}

resource "aws_subnet" "private_subnet_app_az3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_app_az3_cidr_block
  availability_zone = data.aws_availability_zones.available_zones.names[2]

  tags = {
    name = "${var.project_name}-private-subnet-az3"
  }
}

# Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route_table_association" "route_table_association_public_sub_az1" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_association_public_sub_az2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_association_public_sub_az3" {
  subnet_id      = aws_subnet.public_subnet_az3.id
  route_table_id = aws_route_table.public_route_table.id
}

# Database Subnet
resource "aws_db_subnet_group" "postgres-subnet-group" {
  name = "main"

  subnet_ids = [
    aws_subnet.private_subnet_app_az1.id,
    aws_subnet.private_subnet_app_az2.id,
    aws_subnet.private_subnet_app_az3.id
  ]

  tags = {
    Name = "My DB subnet group"
  }
}