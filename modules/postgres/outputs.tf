# Database Security Group ID
output "postgres_security_group_id" {
  value = aws_security_group.postgres_security_group.id
}

# Postgress Address
output "postgres_address" {
  value = aws_db_instance.db.address
}