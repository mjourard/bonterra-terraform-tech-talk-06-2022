terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws",
      version = ">= 4.18.0"
    }
  }
}

provider "aws" {
  default_tags {
    # required for dev ops billing 
    tags = {
      Product = var.aws_tag_product
      Env     = var.aws_tag_env
      context = var.aws_tag_context
      Type    = var.aws_tag_type
      Team    = var.aws_tag_team

      # nice to have
      Workspace = terraform.workspace
      Terraform = "true"
    }
  }
}
