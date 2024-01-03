data "aws_rds_engine_version" "engine_info" { # preferred vesion.
  engine       = local.engine
  version      = var.engine_version
  default_only = !local.is_major_engine_version || var.engine_version == null
}

data "aws_iam_account_alias" "current" {}

data "aws_ssm_parameter" "oidc_provider" {
  name = "/managed/cluster/oidc-provider"
}