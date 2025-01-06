output "public_ip" {
  value = module.ec2.public_ip
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "security_group_id" {
  value = module.sg.security_group_id
}

output "lambda_arn" {
  value = module.lambda.lambda_arn
}

output "sqs_url" {
  value = module.sqs.sqs_url
}

output "repository_name" {
    value = module.ecr.repository_name
}