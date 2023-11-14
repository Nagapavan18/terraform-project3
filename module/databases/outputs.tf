# outputs.tf

output "db_instance_address" {
  value = aws_db_instance.default.endpoint
}

