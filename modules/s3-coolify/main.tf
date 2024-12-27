resource "aws_s3_bucket" "coolify_bucket" {
  bucket = "coolify"

  tags = {
    Name = "Coolify"
    Environment = "production"
  }
}

output "bucket" {
  value = aws_s3_bucket.coolify_bucket.bucket
}

output "bucket_name" {
  value = aws_s3_bucket.coolify_bucket.bucket_domain_name
}

output "bucket_endpoint" {
  value = aws_s3_bucket.coolify_bucket.website_endpoint
}
