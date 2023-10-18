terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


# create ec2
resource "aws_instance" "myec2" {
  ami           = var.ami_value
  instance_type = var.instance_type
  subnet_id = var.subnet_id_value
  tags = {
    Name = "myec2"
  }
}