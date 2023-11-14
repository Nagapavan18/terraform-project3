variable "private_subnet_ids" {}
variable "public_subnet_ids" {
  type    = list(string)
  default = []  # Add a default value or replace it with your actual default values
}
// databases/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "rds_sg_id" {
  description = "Security Group ID for RDS"
}

# ... rest of the configuration
