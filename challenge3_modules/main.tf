provider "aws" {
  region = "us-east-2"
}

module "db_server_module" {
  source = "./modules/db_server"
}

module "web_server_module" {
  source = "./modules/web_server"

  web_server_security_group = module.security_groups_module.web_server_security_group_name
}

module "security_groups_module" {
  source = "./modules/security_groups"

  ingress_list = [80, 443]
  egress_list = [80, 443]
}

output "db_server_private_ip_output" {
  value = module.db_server_module.db_server_private_ip
}