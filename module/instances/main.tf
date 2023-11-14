resource "aws_instance" "example" {
  count                = 2
  ami                  = "ami-0fc5d935ebf8bc3bc"
  instance_type        = "t2.micro"
  subnet_id            = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids = [var.ec2_sg_id]
   # Use vpc_security_group_ids instead

  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}