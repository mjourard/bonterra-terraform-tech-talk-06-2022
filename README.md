# Tech Talk Terraform P2

An instructional repo of the different examples that were gone over during my Terraform Tech Talk at Bonterra from 2022-06-15

Example folders and their contents:

## basics

A simple Terraform configuration that uses each of possible main blocks Terraform blocks that demonstrate how each block type might be used.

Creates a new VPC and spins up an EC2 into it.

## optional-infra

A configuration containing a custom module that can be turned on and turned off by updating the `use_optional` variable in optional.auto.tfvars.

When the module is on, an S3 bucket will be created. When it is off, the S3 bucket will not be created and will need to be destroyed manually if it contains data values.
## state 

Demonstrates how to store Terraform state using the remote infrastructure that is provided in AWS. 

Comes with a cloudformation template that is flexible and can be copied to new projects and used out of the box to start using remote state Terraform.

Includes bash scripts to launch the cloudformation template as well as initialize the Terraform configuration to use the backend provided by the CloudFormation template.