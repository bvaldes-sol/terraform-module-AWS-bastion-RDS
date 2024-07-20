# Main AWS Infrastructure
provider "aws" {
  region = var.region
}

# Module Creates Main VPC
module "vpc" {
  source                            = "../modules/vpc"
  region                            = var.region
  cidr_block                        = var.cidr_block
  project_name                      = var.project_name
  public_subnet_az1_cidr_block      = var.public_subnet_az1_cidr_block
  public_subnet_az2_cidr_block      = var.public_subnet_az2_cidr_block
  public_subnet_az3_cidr_block      = var.public_subnet_az3_cidr_block
  private_subnet_app_az1_cidr_block = var.private_subnet_app_az1_cidr_block
  private_subnet_app_az2_cidr_block = var.private_subnet_app_az2_cidr_block
  private_subnet_app_az3_cidr_block = var.private_subnet_app_az3_cidr_block
}

# Module Creates Bastion EC2 host
module "bastion" {
  source                = "../modules/bastion"
  project_name          = module.vpc.project_name
  vpc_id                = module.vpc.vpc_id
  user_ip               = var.user_ip
  aws_ami               = var.aws_ami
  instance_type         = var.instance_type
  key_pair              = var.key_pair
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  availability_zone     = var.availability_zone
}

# Module Creates Database Postgres
module "postgres" {
  source                    = "../modules/postgres"
  project_name              = module.vpc.project_name
  vpc_id                    = module.vpc.vpc_id
  bastion_ip                = module.bastion.bastion_public_ip
  allocated_storage         = var.allocated_storage
  instance_class            = var.instance_class
  #postgres_username         = var.postgres_username
  #postgres_password         = var.postgres_password
  aws_db_subnet_group_id    = module.vpc.aws_db_subnet_group_id
  availability_zone         = var.availability_zone
  bastion_security_group_id = module.bastion.bastion_security_group_id
  postgres_secrets          = var.postgres_secrets
}

output "bastion_id" {
  value = module.bastion.bastion_public_ip
}

output "postgres_id" {
  value = module.postgres.postgres_address
}
