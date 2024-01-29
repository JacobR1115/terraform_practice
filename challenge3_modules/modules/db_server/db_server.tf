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