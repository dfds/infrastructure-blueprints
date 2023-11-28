terraform {
  #   backend "s3" {
  #   }
}

provider "aws" {
  region = var.aws_region
}
# Here are a set of configuratble options for the module
# The module is configured to use the default values
# Any of these can be overridden by passing in a value
# Any variable that is deemed to be a mandatory input should be moved to the core module


module "rds" {
  source            = "git::https://github.com/dfds/aws-modules-rds.git"
  instance_class    = "db.t3.micro" # configurable - what about db.t4g.micro?
  multi_az          = true
  username          = "instance_user" # configurable
  apply_immediately = false           # configurable
  tags = {                            # configurable via merge - also in the core-module
    Name       = "postgresql-instance"
    Example    = "postgresql-instance"
    Repository = ""
  }

  # is_production = true # configurable - should be passed?
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}
