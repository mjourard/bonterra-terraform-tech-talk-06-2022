terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = ">= 4.18.0"
    }
  }
}

# inherit the aws credentials via environment variables OR your .aws config file
provider "aws" {
  default_tags {
    tags = {
      Terraform = "true"
    }
  }
}

# request varaibles from the user that is deploying your config
variable "env_id" {
  description = "(Required) An id to put at the end of resource names to try to guarantee uniqueness between environments."
  type        = string
}

# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# create local variables 
locals {
  az_suffixes = ["a", "b", "c"]
}

# //////////////////////////////
# VPC
# //////////////////////////////
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = join("", ["terraform-techtalk-vpc", var.env_id])
  cidr   = "10.0.0.0/16"

  azs             = [for suffix in local.az_suffixes : join("", [data.aws_region.current.name, suffix])]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  # one_nat_gateway_per_az = true
}

# //////////////////////////////
# SECURITY GROUP
# //////////////////////////////
resource "aws_security_group" "sg_frontend" {
  name   = join("", ["terraform-techtalk-sg-frontend", var.env_id])
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

# //////////////////////////////
# EC2 MODULE
# //////////////////////////////
# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "ec2_cluster" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0"

  name = join("", ["terraform-techtalk-linux", var.env_id])

  ami           = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.sg_frontend.id]
  subnet_id              = module.vpc.public_subnets[1]

}

output "ec2_region" {
  value = data.aws_region.current.name
}
output "ec2_state" {
  value = module.ec2_cluster.instance_state
}
output "ec2_instance_id" {
  value = module.ec2_cluster.id
}

output "ec2_public_ip" {
  value = module.ec2_cluster.public_ip
}

output "ec2_public_dns" {
  value = module.ec2_cluster.public_dns
}
