variable "subscriber_email" {
    description = "Subscriber email"
    type        = string
}

variable "sns_topic_name" {
    description = "The name of the SNS topic"
    type        = string
}

variable "subscriber_email_lambda" {
    description = "Subscriber email for lambda/sns/sqs"
    type = string
}

variable "sns_lambda_topic_name" {
    description = "Lambda SNS topic name"
    type = string
}