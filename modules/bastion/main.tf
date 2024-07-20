# Bastion Security Group
resource "aws_security_group" "bastion_security_group" {
  name   = "${var.project_name}-bastion-sg"
  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.user_ip}/32"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-bastion-sg"
  }
}


# Bastion EC2 Instance
resource "aws_instance" "bastion" {
  ami                         = var.aws_ami
  instance_type               = var.instance_type
  key_name                    = var.key_pair
  associate_public_ip_address = true
  subnet_id                   = var.public_subnet_az1_id
  security_groups             = [aws_security_group.bastion_security_group.id]
  availability_zone           = var.availability_zone

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "${var.project_name}-bastion"
  }

  lifecycle {
    ignore_changes = [
      ami, disable_api_termination, ebs_optimized,
      hibernation, security_groups, credit_specification,
      network_interface, ephemeral_block_device
    ]
  }
}


# IAM association for the Bastion Host
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.role.name
}

# IAM Permissions Document
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# IAM Role for Bastion
resource "aws_iam_role" "role" {
  name               = "${var.project_name}-ec2-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}