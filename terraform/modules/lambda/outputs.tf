output "lambda_arn" {
  value = aws_lambda_function.lambda_function.arn
}

output "lambda_func_name" {
  value = aws_lambda_function.lambda_function.function_name
}