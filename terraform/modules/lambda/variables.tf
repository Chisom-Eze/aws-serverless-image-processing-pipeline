variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "filename" {
  type = string
}

variable "table_name" {
  type = string
}

variable "sqs_arn" {
  type = string
}

variable "processed_bucket" {
  type = string
}