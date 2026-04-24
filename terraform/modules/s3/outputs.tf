output "raw_bucket_id" {
  value = aws_s3_bucket.raw.id
}

output "processed_bucket_id" {
  value = aws_s3_bucket.processed.id
}

output "raw_bucket_arn" {
  value = aws_s3_bucket.raw.arn
}

output "processed_bucket_domain_name" {
  value = aws_s3_bucket.processed.bucket_regional_domain_name
}

output "processed_bucket_arn" {
  value = aws_s3_bucket.processed.arn
}