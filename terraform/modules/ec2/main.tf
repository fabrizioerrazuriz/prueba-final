resource "aws_instance" "ec2_api_instance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.security_group_id]
  key_name = var.key_name
  iam_instance_profile = var.iam_instance_profile

  user_data = <<-EOT
              #!/bin/bash
              yum update -y
              yum install -y awslogs
              echo 'Logs configured!'
              EOT
  tags = {
    Name = var.name
  }
}

