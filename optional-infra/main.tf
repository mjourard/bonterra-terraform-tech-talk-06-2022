# set if we are going to create the optional infra
locals {
  use_optional = var.use_optional ? 1 : 0
}

# //////////////////////////////
# VPC
# //////////////////////////////
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/3.14.0
module "optional" {
  source = "./my-mod"
  count  = local.use_optional
  env_id = var.env_id
}

output "optional_bucket" {
  value = module.optional.*.bucket
}
