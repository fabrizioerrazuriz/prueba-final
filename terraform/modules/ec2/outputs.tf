output "instance_id" {
  value = aws_instance.ec2_api_instance.id
}

output "public_ip" {
  value = aws_instance.ec2_api_instance.public_ip
}
