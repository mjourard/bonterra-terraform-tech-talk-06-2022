# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "example_bucket" {
  bucket = join("-", ["tech-talk-bucket-optional-infra", var.env_id, data.aws_region.current.name])
}


output "bucket" {
  value = aws_s3_bucket.example_bucket.id
}
