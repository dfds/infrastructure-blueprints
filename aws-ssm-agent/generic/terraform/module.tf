terraform {
  backend "s3" {
    bucket         = "<your_bucket_name>-state-bucket"
    encrypt        = true
    key            = "<your-folder-name>/terraform.tfstate" # This is the path to the state file inside the bucket. You can change it to whatever you want.
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}


provider "aws" {
  region = "eu-central-1"
}


module "db_instance" {
  source = "git::https://github.com/dfds/terraform-aws-ssm-agent?ref=2.0.0"

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

output "connection_command" {
  description = "None"
  value       = try(module.db_instance.connection_command, null)
}
output "instance_id" {
  description = "None"
  value       = try(module.db_instance.instance_id, null)
}
