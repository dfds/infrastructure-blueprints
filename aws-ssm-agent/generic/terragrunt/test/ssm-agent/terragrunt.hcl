terraform {
  source = "git::https://github.com/dfds/terraform-aws-ssm-agent//?ref=1.0.1"
}

# Include all settings from the parent terragrunt.hcl file
include "root" {
  path = find_in_parent_folders()
}

# Include env.hcl for environment specific settings
include "env" {
  path = find_in_parent_folders("env.hcl")
}

inputs = {

  #     Provide a cost centre for the resource.
  #     Valid Values: .
  #     Notes: This set the dfds.cost_centre tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
  cost_centre = "example"

  #     Specify the staging environment.
  #     Valid Values: "dev", "test", "staging", "uat", "training", "prod".
  #     Notes: The value will set configuration defaults according to DFDS policies.
  environment = "example"

  #     Specify service availability.
  #     Valid Values: low, medium, high
  #     Notes: This set the dfds.service.availability tag. See recommendations [here](https://wiki.dfds.cloud/en/playbooks/standards/tagging_policy).
  service_availability = "example"
}
