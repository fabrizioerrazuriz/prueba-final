# Rol para instancias EC2
resource "aws_iam_role" "ec2_cloudwatch_role" {
  name = "ec2-cloudwatch-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Permisos de logs para el rol
resource "aws_iam_role_policy" "ec2_cloudwatch_policy" {
  name   = "ec2-cloudwatch-logs-policy"
  role   = aws_iam_role.ec2_cloudwatch_role.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
# Asociación
resource "aws_iam_instance_profile" "ec2_cloudwatch_profile" {
  name = "ec2-cloudwatch-logs-profile"
  role = aws_iam_role.ec2_cloudwatch_role.name
}

# Rol para Lambda
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Política para el rol (logs, publicar en sns y recibir/borrar de sqs)
resource "aws_iam_policy" "lambda_execution_policy" {
  name = "lambda-execution-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sns:Publish",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Asociación
resource "aws_iam_role_policy_attachment" "attach_lambda_execution_policy" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_execution_policy.arn
}

# Rol SQS
resource "aws_iam_role" "sqs_execution_role" {
  name = "sqs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "lambda.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
# Políticas del rol para SQS
resource "aws_iam_policy" "sqs_execution_policy" {
  name = "sqs-execution-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "lambda:CreateEventSourceMapping",
          "lambda:ListEventSourceMappings",
          "lambda:ListFunctions"
        ]
        Resource = "*"
      }
    ]
  })
}
# Asociación
resource "aws_iam_role_policy_attachment" "attach_sqs_execution_policy" {
  role       = aws_iam_role.sqs_execution_role.name
  policy_arn = aws_iam_policy.sqs_execution_policy.arn
}