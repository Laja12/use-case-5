terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  subnet_cidr       = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

module "ec2" {
  source         = "./modules/ec2"
  ami_id         = "ami-084568db4383264d4" # Ubuntu 20.04 in us-east-1
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.subnet_id
  vpc_id         = module.vpc.vpc_id
  key_name       = "ssh-key"
}
