# Security Group for Database
resource "aws_security_group" "postgres_security_group" {
  name   = "${var.project_name}-postgres-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 5432
    to_port   = 5432
    #cidr_blocks = ["${var.bastion_ip}/32"]
    security_groups = ["${var.bastion_security_group_id}"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-postgres-sg"
  }
}

data "aws_secretsmanager_secret_version" "creds" {
  # Fill in the name you gave to your secret
  secret_id = "${var.postgres_secrets}"
}

locals {
  db_creds = jsondecode(
    data.aws_secretsmanager_secret_version.creds.secret_string
  )
}

# Database Instance
resource "aws_db_instance" "db" {
  allocated_storage = var.allocated_storage
  engine            = "postgres"
  instance_class    = var.instance_class

  db_name    = "postgres"
  identifier = "postgres"
  username   = local.db_creds.postgres_username #var.postgres_username
  password   = local.db_creds.postgres_password #var.postgres_password

  availability_zone      = var.availability_zone
  db_subnet_group_name   = var.aws_db_subnet_group_id
  vpc_security_group_ids = [aws_security_group.postgres_security_group.id]

  publicly_accessible = false
  skip_final_snapshot = true
}