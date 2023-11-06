provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "var.instance_type"

  tags = {
    Name = "terraform-example"
  }

}
