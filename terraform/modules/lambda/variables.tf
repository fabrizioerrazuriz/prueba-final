variable "lambda_sns_topic_arn" {
  description = "ARN del SNS topic linkeado al lambda"
  type = string
}

variable "lambda_exec_role_arn" {
  description = "Rol (arn) asignado al lambda"
  type = string
}

variable "lambda_sqs_queue_arn" {
  description = "ARN del SQS queue que triggerea el lambda"
  type = string
}