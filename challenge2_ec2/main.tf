provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "db_server" {
  ami = "ami-0a9a47155910e782f"
  instance_type = "t2.micro"

  tags = {
    name = "DB Server"
  }
}

output "db_server_private_ip" {
  value = aws_instance.db_server.private_ip
}

resource "aws_instance" "web_server" {
  ami = "ami-0a9a47155910e782f"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.web_server_sg.name]
  user_data = file("${path.module}/server-script.sh")

  tags = {
    name = "Web Server"
  }
}

resource "aws_eip" "eip" {
  instance = aws_instance.web_server.id
}

resource "aws_security_group" "web_server_sg" {
  name = "web_server_sg"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_list
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress_list
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ingress_list" {
  type = list(number)
  default = [80, 443]
}

variable "egress_list" {
  type = list(number)
  default = [80, 443]
}
