variable "project" {
  description = "(Required) first initial last name of the person deploying the terraform template. Matthew Jourard = mjourard"
  type        = string
}

variable "environment" {
  description = "(Required) first initial last name of the person deploying the terraform template. Matthew Jourard = mjourard"
  type        = string
}



# billing tag variables
variable "aws_tag_product" {
  description = "(Required) A tag value required by Cloud Ops to track infrastructure billing costs."
  type        = string
}
variable "aws_tag_env" {
  description = "(Required) A tag value required by Cloud Ops to track infrastructure billing costs."
  type        = string
}
variable "aws_tag_context" {
  description = "(Required) A tag value required by Cloud Ops to track infrastructure billing costs."
  type        = string
}
variable "aws_tag_type" {
  description = "(Required) A tag value required by Cloud Ops to track infrastructure billing costs."
  type        = string
}
variable "aws_tag_team" {
  description = "(Required) A tag value required by Cloud Ops to track infrastructure billing costs."
  type        = string
}
