module "automation-dev" {
  source                              = "../../modules/rds"
  name                                = "automation-dev"
  env                                 = var.environment
  azs                                 = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  instance_class                      = "db.t2.medium"
  subnets                             = module.vpc.database_subnets
  vpc_id                              = module.vpc.vpc_id
  cluster_size                        = "1"
  allowed_cidr                        = concat(var.vpc_private_subnets, var.vpc_public_subnets, var.vpc_database_subnets,)
  database_name                       = "automation"
  master_username                     = "automation"
  master_password                     = "i7fz0vl29g1k433niw"
  iam_database_authentication_enabled = true
  backup_retention_period             = var.backup_retention_period_lab
  engine                              = "aurora-mysql"
  major_engine_version                = "5.7"
  family                              = "aurora-mysql5.7"
  cluster_parameters                  = var.automation_cluster_parameters
  db_parameters                       = var.automation_db_parameters
  ca_cert_identifier                  = "rds-ca-2019"
  target_backtrack_window             = "0"

  tags = {
    environment   = var.environment
    application   = "automation-dev"
    data-category = "internal"
    created-by    = "terraform"
  }
}

resource "aws_route53_record" "db-automation-dev" {
  zone_id = data.aws_route53_zone.dev.zone_id
  name    = "db.automation-dev"
  type    = "CNAME"
  ttl     = "30"
  records = [module.automation-dev.writer_endpoint]
}