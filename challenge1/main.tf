provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "challenge1vpc" {
  cidr_block = "1.92.168.0.0/24"
  tags = {
    Name = "TerraformVPC"
  }
}