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
}

variable "egress_list" {
  type = list(number)
}

output "web_server_security_group_name" {
  value = aws_security_group.web_server_sg.name
}