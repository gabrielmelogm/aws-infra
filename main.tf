provider "aws" {
  region = var.region
}

module "vpc_playground" {
  source = "./modules/vpc-playground"
  ami_id      = "ami-0e2c8caa4b6378d8c"
  key_name    = var.key_name
  public_key  = var.public_key
  availability_zone = var.availability_zone
}
