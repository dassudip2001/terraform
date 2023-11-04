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
  region = "ap-south-1"
}

resource "aws_instance" "web" {
  ami = "ami-0287a05f0ef0e9d9a"
  # instance type comes form 
  instance_type = var.instamce
  # number of instance 
  count = var.number_of_instance

  # enable ip address
  associate_public_ip_address = var.eneable_elastic_ip
  # tags comes form enverment
  tags = var.project_enverment

}
