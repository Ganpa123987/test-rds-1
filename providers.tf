terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "sriram-terraform-state-lab"
    key            = "dev/automation-dev.tfstate"
    dynamodb_table = "terraform-state-lock-lab-eu-west-1-dev"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.72"
    }
    sops = {
      source  = "carlpett/sops"
      version = "0.5.1"
    }
  }
  
    required_version = "~> 1.1.3"
}

provider "aws" {
  region = var.region
}

provider "sops" {}
