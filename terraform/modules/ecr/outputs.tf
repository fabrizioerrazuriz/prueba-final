output "repository_name" {
  value = aws_ecr_repository.ecr_repository.name
}

output "repository_url" {
  value = aws_ecr_repository.ecr_repository.repository_url
}

output "repository_registry_id" {
  value = aws_ecr_repository.ecr_repository.registry_id
}