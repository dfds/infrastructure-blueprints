inputs = {
    #     Specify the staging environment.
    #     Valid Values: "dev", "test", "staging", "uat", "training", "prod".
    #     Notes: The value will set configuration defaults according to DFDS policies.
    environment = "test"

    #     Provide a cost centre for the resource.
    #     Valid Values: .
    #     Notes: This set the dfds.cost_centre tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
    cost_centre = "example"
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-central-1"
}
EOF
}
