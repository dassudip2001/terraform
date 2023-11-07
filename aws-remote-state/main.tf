# terraform {
#   backend "s3" {
#     bucket = "terraform-remote-state-123456789"
#     key    = "sudip/terraform.tfstate"
#     region = "us-east-1"

#   }
# }

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0287a05f0ef0e9d9a"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-demo"
  }
}


# out put ec2 instance public ip
output "public_ip" {
  value = aws_instance.web.public_ip
}



resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-remote-state-123456789"
  #   acl    = "private"

  tags = {
    Name        = "terraform-remote-state"
    Environment = "Dev"
  }
}
