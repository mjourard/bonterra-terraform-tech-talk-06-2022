# request varaibles from the user that is deploying your config
variable "env_id" {
  description = "(Required) An id to put at the end of resource names to try to guarantee uniqueness between environments."
  type        = string
}

variable "use_optional" {
  type = bool
}
