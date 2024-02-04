# main.tf

provider "aws" {
  region = var.aws_region
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "my_ec2_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name
  iam_instance_profile        = "LabInstanceProfile"
  tags = {
    Name = "assignment1instance"
  }
  
}

resource "aws_ecr_repository" "ecr_assignment1_repo" {
  name = "ecr_assignment1_repo"
  image_tag_mutability = "MUTABLE" 
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file(var.public_key_path)
}

