terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.48.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_playground" {
  source = "./modules/vpc-playground"
  region      = "us-east-1"
  ami_id      = "ami-0e2c8caa4b6378d8c"
  key_name    = "my-key"
  public_key  = file("~/.ssh/playground.pem.pub")
  availability_zone = "us-east-1a"
}
