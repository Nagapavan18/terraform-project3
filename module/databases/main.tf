// databases/main.tf

resource "aws_db_subnet_group" "example" {
  name        = "my-new-db-subnet-group-12"
  description = "my-new-db-subnet-group-12"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "MyNewDBSubnetGroup"
  }
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "default" {
  allocated_storage             = 10
  identifier                    = "rds-db"
  db_name                       = "mydb"
  engine                        = "mysql"
  engine_version                = "5.7"
  instance_class                = "db.t3.micro"
  manage_master_user_password   = true
  master_user_secret_kms_key_id = aws_kms_key.example.key_id
  username                      = "foo"
  parameter_group_name          = "default.mysql5.7"
  vpc_security_group_ids        = [var.rds_sg_id]
  db_subnet_group_name          = aws_db_subnet_group.example.name
  skip_final_snapshot           = true  # Avoid creating a final snapshot during deletion
  final_snapshot_identifier     = "rds-db-snapshot5"  # Provide a different identifier
}
