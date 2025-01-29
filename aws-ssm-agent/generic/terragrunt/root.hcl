remote_state {
  backend = "s3"
  config = {
    bucket         = "<your_bucket_name>-state-bucket"
    encrypt        = true
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}
