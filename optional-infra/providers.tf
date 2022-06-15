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
