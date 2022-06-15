# Tech Talk Terraform P2

An instructional repo of the different examples that were gone over during my Terraform Tech Talk at Bonterra from 2022-06-15

Example folders and their contents:

## state 

Demonstrates how to store Terraform state using the remote infrastructure that is provided in AWS. 

Comes with a cloudformation template that is flexible and can be copied to new projects and used out of the box to start using remote state Terraform.

Includes bash scripts to launch the cloudformation template as well as initialize the Terraform configuration to use the backend provided by the CloudFormation template.