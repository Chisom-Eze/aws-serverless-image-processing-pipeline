resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-lambda-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Principal = {
        Service = "lambda.amazonaws.com"
       }
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "${var.project_name}-lambda-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
{
  Effect = "Allow"
  Action = [
    "s3:GetObject",
    "s3:GetObjectVersion"
  ]
  Resource = "arn:aws:s3:::chisom-raw-images/*"
},
{
  Effect = "Allow"
  Action = [
    "s3:PutObject"
  ]
  Resource = "arn:aws:s3:::chisom-processed-images/*"
},
{
  Effect = "Allow"
  Action = [
    "s3:ListBucket"
  ]
  Resource = "arn:aws:s3:::chisom-raw-images"
},

{
  Effect = "Allow"
  Action = [
    "dynamodb:PutItem"
  ]
  Resource = "arn:aws:dynamodb:us-east-1:625444834398:table/serverless-image-pipeline-images"
},
        {
            Effect = "Allow"
            Action = [
                "sqs:ReceiveMessage",
                "sqs:DeleteMessage",
                "sqs:GetQueueAttributes"
            ]
            Resource = "*"
          
        },
        {
            Effect = "Allow"
            Action =[
                "logs:*"
            ]
            Resource = "*"
        }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}