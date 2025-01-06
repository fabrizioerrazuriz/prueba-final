# Activar alarma si la CPU supera el 80%
resource "aws_cloudwatch_metric_alarm" "high_cpu_usage" {
  alarm_name          = "High-CPU-Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Alarma si el tráfico de red entrante supera 1MB (lo más cercano a requests por segundo).
resource "aws_cloudwatch_metric_alarm" "high_network_in" {
  alarm_name          = "High-Network-In"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Sum"
  threshold           = 1000000
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.instance_id
  }
}

# Alarma para fallos de instancia
resource "aws_cloudwatch_metric_alarm" "status_check_failed" {
  alarm_name          = "Instance-Check-Failed"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Maximum"
  threshold           = 1
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    InstanceId = var.instance_id
  }
}
