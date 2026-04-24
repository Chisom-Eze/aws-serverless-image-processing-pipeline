variable "raw_bucket_name" {
  type = string
  default = "chisom-raw-images"
}

variable "processed_bucket_name" {
  type = string
  default = "chisom-processed-images"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "sqs_queue_arn" {
  type = string
}

variable "sqs_policy_dependency" {
  type = any
}