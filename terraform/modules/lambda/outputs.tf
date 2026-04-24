output "lambda_function_name" {
  value = aws_lambda_function.image_processor.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.image_processor.arn
}