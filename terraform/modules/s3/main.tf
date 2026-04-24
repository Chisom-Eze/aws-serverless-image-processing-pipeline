resource "aws_s3_bucket" "raw" {
  bucket = var.raw_bucket_name

tags = {
    Name = "raw-images-bucket"
    Environment = var.environment
 }
}

resource "aws_s3_bucket" "processed" {
  bucket = var.processed_bucket_name

  tags = {
    Name = "processed-images-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "raw_block" {
  bucket = aws_s3_bucket.raw.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "processed_block" {
  bucket = aws_s3_bucket.processed.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "raw_versioning" {
  bucket = aws_s3_bucket.raw.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_versioning" "processed_versioning" {
  bucket = aws_s3_bucket.processed.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_notification" "sqs_notification" {
  bucket = aws_s3_bucket.raw.id

  queue {
    queue_arn = var.sqs_queue_arn
    events = ["s3:ObjectCreated:*"]
  }

  depends_on = [var.sqs_policy_dependency]
}