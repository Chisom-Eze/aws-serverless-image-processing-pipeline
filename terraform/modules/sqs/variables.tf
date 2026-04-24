variable "project_name" {
  type = string
}

variable "environment" {
  type = string
  default = "dev"
}

variable "s3_bucket_arn" {
  type        = string
}