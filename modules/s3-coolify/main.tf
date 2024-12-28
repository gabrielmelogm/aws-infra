resource "aws_s3_bucket" "coolify" {
  bucket = "coolify"
  acl = "private"
}

output "s3_endpoint" {
  value = aws_s3_bucket.coolify.website_endpoint
}

output "s3_bucket" {
  value = aws_s3_bucket.coolify.bucket
}
