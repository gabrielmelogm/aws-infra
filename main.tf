provider "aws" {
  region = var.region
}

module "ec2_playground" {
  source = "./modules/ec2-playground"
  ami_id      = "ami-0e2c8caa4b6378d8c"
  key_name    = var.key_name
  public_key  = var.public_key
  availability_zone = var.availability_zone
}

output "public_ip" {
  value = module.ec2_playground.public_ip
}

output "public_dns" {
  value = module.ec2_playground.public_dns
}
