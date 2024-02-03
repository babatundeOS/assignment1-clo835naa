# main.tf

provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

# Create VPC with a public subnet
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a" # Change this to your desired availability zone
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Create an EC2 instance in the public subnet
resource "aws_instance" "my_instance" {
  ami           = "ami-0ff8a91507f77f867"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "my-instance"
  }
}


# Create an Elastic Container Registry (ECR)

resource "aws_ecr_repository" "ecr_assignment1_db_repo" {
  name = "ecr_assignment1_db_repo"
  image_tag_mutability = "MUTABLE" 
}

resource "aws_ecr_repository" "ecr_assignment1_app_repo" {
  name = "ecr_assignment1_app_repo"
  image_tag_mutability = "MUTABLE"
}
