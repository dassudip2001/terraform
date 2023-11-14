# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}




# create s3 bucket for terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-remote-state-123456789"
  #   acl    = "private"

  tags = {
    Name        = "terraform-remote-state"
    Environment = "Dev"
  }
}
