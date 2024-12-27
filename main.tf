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
