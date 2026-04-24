module "s3" {
  source = "./modules/s3"

  raw_bucket_name       = var.raw_bucket_name
  processed_bucket_name = var.processed_bucket_name
  environment           = var.environment
  sqs_queue_arn         = module.sqs.queque_arn

  sqs_policy_dependency = module.sqs
}

module "sqs" {
  source        = "./modules/sqs"
  project_name  = var.project_name
  environment   = var.environment
  s3_bucket_arn = module.s3.raw_bucket_arn
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "lambda" {
  source = "./modules/lambda"

  project_name     = var.project_name
  environment      = var.environment
  lambda_role_arn  = module.iam.lambda_role_arn
  sqs_arn          = module.sqs.queque_arn
  processed_bucket = module.s3.processed_bucket_id
  table_name       = module.dynamodb.table_name
  filename         = "../lambda/lambda.zip"
}

module "dynamodb" {
  source = "./modules/dynamodb"

  project_name = var.project_name
  environment  = var.environment

}

module "cloudfront" {
  source = "./modules/cloudfront"
  project_name = var.project_name
  bucket_domain_name = module.s3.processed_bucket_domain_name
  bucket_arn = module.s3.processed_bucket_arn
}

