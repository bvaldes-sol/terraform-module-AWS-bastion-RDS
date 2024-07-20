# Region to deploy AWS Services
region="us-east-2"

#CIDR block for VPC main
cidr_block="10.0.0.0/16"

# Naming for infrastructure services
project_name="dev-rds-project"

# Public Subnets CIDR Blocks
public_subnet_az1_cidr_block="10.0.1.0/24"
public_subnet_az2_cidr_block="10.0.2.0/24"
public_subnet_az3_cidr_block="10.0.3.0/24"

# Private Subnets CIDR Blocks
private_subnet_app_az1_cidr_block="10.0.4.0/24"
private_subnet_app_az2_cidr_block="10.0.5.0/24"
private_subnet_app_az3_cidr_block="10.0.6.0/24"

# Bastion Configuration
user_ip="0.0.0.0" #user IP to whitelist for bastion
aws_ami="ami-0649bea3443ede307"
instance_type="t2.micro"
key_pair="example-key" # put ssh key name here from AWS Key Pair

# Postgres Configuration
allocated_storage="5"
instance_class="db.t3.micro"
postgres_secrets="example_DB_secrets" #secret_ID from AWS Secret manager
#postgres_username="dbadmin"  #user for db 
#postgres_password="satl$icH5PR!CU#wA-Ok" #pw for db

# Specific AZ want resources
availability_zone="us-east-2a"