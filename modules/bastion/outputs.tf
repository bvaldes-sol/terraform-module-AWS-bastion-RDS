# Bastion Security Group ID
output "bastion_security_group_id" {
  value = aws_security_group.bastion_security_group.id
}

# Bastion Private IP
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}