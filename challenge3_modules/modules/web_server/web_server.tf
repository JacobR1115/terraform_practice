resource "aws_instance" "web_server" {
  ami = "ami-0a9a47155910e782f"
  instance_type = "t2.micro"
  security_groups = var.web_server_security_group
  user_data = file("${path.module}/server-script.sh")

  tags = {
    name = "Web Server"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id
}

variable "web_server_security_group" {
  type = string
}