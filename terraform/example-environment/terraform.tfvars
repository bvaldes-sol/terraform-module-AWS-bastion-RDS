# Region to deploy AWS Services
region=""

#CIDR block for VPC main
cidr_block=""

# Naming for infrastructure services
project_name=""

# Public Subnets CIDR Blocks
public_subnet_az1_cidr_block=""
public_subnet_az2_cidr_block=""
public_subnet_az3_cidr_block=""

# Private Subnets CIDR Blocks
private_subnet_app_az1_cidr_block=""
private_subnet_app_az2_cidr_block=""
private_subnet_app_az3_cidr_block=""

# Bastion Configuration
user_ip="" #user IP to whitelist for bastion
aws_ami=""
instance_type=""
key_pair="" # put ssh key name here from AWS Key Pair

# Postgres Configuration
allocated_storage=""
instance_class=""
postgres_secrets="" #secret_ID from AWS Secret manager

#postgres_username=""  #user for db 
#postgres_password="" #pw for db

# Specific AZ you want resources in, you'd need to ensure the bastion and DB get deployed initially same AZ to avoid extra costs.
availability_zone="" #example us-east-2a