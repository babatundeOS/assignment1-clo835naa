# main.tf

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
  #security_groups = [aws_security_group.my_security_group.id]
  key_name      = aws_key_pair.my_key.key_name
  
  tags = {
    Name = "assignment1instance"
  }
  
}

resource "aws_ecr_repository" "ecr_assignment1_db_repo" {
  name = "ecr_assignment1_db_repo"
  image_tag_mutability = "MUTABLE" 
}

resource "aws_ecr_repository" "ecr_assignment1_app_repo" {
  name = "ecr_assignment1_app_repo"
  image_tag_mutability = "MUTABLE"
}

resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow inbound traffic on specified ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8083
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = file(var.public_key_path)
}

