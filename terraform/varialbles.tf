variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "raw_bucket_name" {
  description = "Name of raw images bucket"
  type        = string
}

variable "processed_bucket_name" {
  description = "Name of processed images bucket"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Name of project"
  type        = string
  default     = "serverless-image-pipeline"
}

