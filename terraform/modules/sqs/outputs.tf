output "queque_arn" {
  value = aws_sqs_queue.main.arn
}

output "queque_url" {
  value = aws_sqs_queue.main.id
}

output "dlq_arn" {
  value = aws_sqs_queue.dlq.arn
}