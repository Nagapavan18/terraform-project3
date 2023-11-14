module "network" {
  source                  = "./module/network"
  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  vpc_name                = "my-vpc1"
  public_subnet_names     = ["public-subnet-1"]
  private_subnet_names    = ["private-subnet-1"]
  igw_name                = "my-igw"
  public_route_table_name = "public-route-table"
  private_route_table_name = "private-route-table"
}

module "instances" {
  source             = "./module/instances"
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  ec2_sg_id          = module.security.ec2_security_group_id # Reference the ec2_sg_id from the network module
}

module "databases" {
  source              = "./module/databases"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  rds_sg_id           = module.security.rds_security_group_id
  # Add other necessary arguments
}
module "security" {
  source              = "./module/security"
  vpc_id              = module.network.vpc_id
  


}