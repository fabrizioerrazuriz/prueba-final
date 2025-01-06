variable "instance_id" {
    description = "The instance ID to monitor"
    type        = string
}

variable "sns_topic_arn" {
    description = "The ARN of the SNS topic to send notifications"
    type        = string
}