# Terraform Remote State Template
![Static Badge](https://img.shields.io/badge/Terraform-V1.8.0-%23844FBA?logo=terraform) ![Static Badge](https://img.shields.io/badge/AWS_CLI-V2.15.19-%23232F3E?logo=amazonaws)

- Module formatted for multi environment IAC that deploys a private Postgres Database on AWS RDS, EC2 bastion host, and VPC. The modular project purpose is to be able to create bastions and private databases to add aditional layers of security and be used for testing.

### | [Installation](#installation) | [Configuration](#configuration) | [Usage](#usage) | [Clean Up](#clean-up) |

![Terraform Remote state](https://github.com/bvaldes-sol/terraform-module-AWS-bastion-RDS/blob/main/Terraform%20Module%20Bastion%20RDS.png?raw=true)

## Who is this for?

- This project is useful to AWS Terraform Admins or Devs looking to have a multi environment module to deploy resources with your custom values making it more simple to add to their IAC infrastructure.
- The secrets are also stored in AWS secrets manager for security best practices.

## Installation

- AWS IAM user with Administrator Access
- AWS Key Pair
- SSH client
- AWS Secrets Manager for database secrets
- AWS CLI
- Postgres SQL
- Terraform
- Your IPv4

### AWS
#### AWS IAM User 

• Configure an IAM user with the Administrator Access.
• Then ensure in your user creation the IAM has your programmatic access created too.

#### AWS CLI setup

• Setup is based on your machine's operating system please follow AWS documententation linked below as its the most up to date and fastest process to download and configure.
- https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html


### AWS Configurations

• After creating your user that has programmatic access to with permissions to services you will be deploying on AWS, you head to your terminal and issue the cmd. 
- `$ aws configure --profile insert-name-here`

• Follow the prompts and fill in the data you have from your programmtic access.


### Terraform
#### Terraform CLI setup

• Setup is based on your machine's operating system please follow Hashicorp documententation linked below as its the most up to date and fastest process to download and configure.
- https://learn.hashicorp.com/tutorials/terraform/install-cli



## Configuration

### Terraform


#### `terraform.tfvars` 

- Go to terraform > example-environment > terraform.tfvars

terraform.tfvars file hold your custom values for the infrastructure to be created. These values then get propagated to the main.tf which sources to the rest of the modules 'vpc', 'bastion', 'postgres'. terraform.tfvars file cant have any spaces between the attributes and



    -      region="insert-region-for-infrastructure"
    -      cidr_block="main-cidr-block-for-VPC"
    -      project_name="insert-project-name"


    -      public_subnet_az1_cidr_block="cidr-block-for-availability-zone-1a"
    -      public_subnet_az2_cidr_block="cidr-block-for-availability-zone-1b"
    -      public_subnet_az3_cidr_block="cidr-block-for-availability-zone-1c"

    -      private_subnet_az1_cidr_block="cidr-block-for-availability-zone-1a"
    -      private_subnet_az2_cidr_block="cidr-block-for-availability-zone-1b"
    -      private_subnet_az3_cidr_block="cidr-block-for-availability-zone-1c"

    -      user_ip="insert-your-IP-address-to-whitelist-for-bastion"
    -      aws_ami="ami-image-for-bastion-EC2"
    -      instance_type="instance-size-for-bastion-EC2"
    -      key_pair="AWS-key-pair-for-ssh-to-bastion"

    -      allocated_storage="allocated-database-storage"
    -      instance_class="instance-size-for-database"
    -      postgres_secrets="AWS-Secrets-Manager-secret_ID"


## Usage

- Now that we're setup, ensure your at the file directory and run the following commands, if you get stuck seek my troubleshoot section.

```
console
foo@bar:~$ terraform init

foo@bar:~$ terraform plan

foo@bar:~$ terraform apply
```
- After infrastructure is completed, you can issue ssh portforward from the bastion.

```
foo@bar:~$ ssh -i "C:\Users\admin-user\.ssh\public-key-aws-key-pair.pem" -N -L 5433:database-endpoint:5432 ec2-user@ec2-Public-IPv4-DNS -v
```
- In the command above you'll need to update referencing where you stored your public SSH key
    - "C:\Users\admin-user\.ssh\public-key-aws-key-pair.pem"

- Update your RDS database endpoint from the terraform output. 
    - "database-endpoint"

- Finally update the EC2 Public IPv4 from the terraform output. 
    - "ec2-Public-IPv4-DNS"

- Example of complete command:
```
Console
foo@bar:~$ ssh -i "C:\Users\admin\.ssh\project-public-key.pem" -N -L 5433:postgres.cdf24erlakua.us-east-2.rds.amazonaws.com:5432 ec2-user@ec2-18-118-227-251.us-east-2.compute.amazonaws.com -v
```
- Your current terminal will be port forward you can open a new terminal and login to the database.

```
Console
foo@bar:~$ psql -h 127.0.0.1 -U insert-username -p 5433 -d insert-database-name
```
- You'll then be prompted for the database password.

Afterwards you'll be logged into the Postgres database.

## Clean Up

```
terraform destroy -auto-approve
```