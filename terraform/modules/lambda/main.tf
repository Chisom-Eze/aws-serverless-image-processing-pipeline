resource "aws_lambda_function" "image_processor" {
  function_name = "${var.project_name}-image_processor"
  role = var.lambda_role_arn
  handler = "handler.lambda_handler"
  runtime = "python3.11"

  filename = "${path.module}/lambda.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda.zip")

  timeout = 30

  environment {
    variables = {
        PROCESSED_BUCKET = var.processed_bucket
        TABLE_NAME       = var.table_name
    }
  } 
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = var.sqs_arn
  function_name = aws_lambda_function.image_processor.arn
}