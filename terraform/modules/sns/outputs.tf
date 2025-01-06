output "sns_topic_arn" {
  value = aws_sns_topic.alarm_notifications.arn
}
output "sns_lambda_topic_arn" {
  value = aws_sns_topic.lambda_topic.arn
}