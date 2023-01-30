module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  version              = "2.70.0"
  name                 = var.environment
  cidr                 = var.vpc_cidr
  private_subnets      = var.vpc_private_subnets
  database_subnets     = var.vpc_database_subnets
  public_subnets       = var.vpc_public_subnets
  enable_nat_gateway   = var.vpc_enable_nat_gateway
  azs                  = var.vpc_azs
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_s3_endpoint   = true

  tags = {
    environment = var.environment
    application = "vpc"
  }

}
