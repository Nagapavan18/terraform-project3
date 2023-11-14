variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "ec2_sg_id" {
  description = "Security Group ID for RDS"
}

