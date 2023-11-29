provider "aws" {
  region = "us-east-1"
}


resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


resource "aws_instance" "example" {
  count                = 2
  ami                  = "ami-0fc5d935ebf8bc3bc"
  instance_type        = "t2.micro"
  subnet_id            = element(var.public_subnet_ids, count.index)
  vpc_security_group_ids = [var.ec2_sg_id]
  key_name ="terraformproject"      # replace your pem file here .
  iam_instance_profile = "roleforec2codedeploy"

  user_data = <<-EOF
    #!/bin/bash
    # Install CodeDeploy agent and Docker
    sudo apt-get update -y
    sudo apt-get install -y ruby wget

    # Install CodeDeploy agent
    cd /home/ubuntu
    wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install
    chmod +x ./install
    sudo ./install auto

    # Install Docker
    sudo apt-get install -y docker.io
    sudo usermod -aG docker ubuntu
    sudo systemctl enable docker
    sudo systemctl start docker
    # Install AWS CLI
    sudo apt-get install -y awscli
    # Install mysql
    sudo apt install mysql-client-core-8.0
    EOF

  tags = {
    Name = "ExampleInstance-${count.index + 1}"
  }
}
