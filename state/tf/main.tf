resource "aws_s3_bucket" "example_bucket" {
  bucket = join("-", ["tech-talk-bucket", var.project, var.environment])
}
