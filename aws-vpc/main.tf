provider "aws" {
  region = "ap-south-1"

}

locals {
  stagging_env = "staging"
}

resource "aws_vpc" "staging_vpc" {
  cidr_block = ""
  tags = {
    Name = "${local.stagging_env}_vpc"
  }
}


resource "aws_subnet" "staging_subnet" {
  vpc_id            = aws_vpc.staging_vpc.id
  cidr_block        = ""
  availability_zone = "ap-south-1a"
  tags = {
    Name = "staging_subnet"
  }

}


resource "aws_instance" "ec2_example" {
  ami           = "ami-0e306788ff2473ccb"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.staging_subnet.id
  tags = {
    Name = "ec2_example"
  }

}
