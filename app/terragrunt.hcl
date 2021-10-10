iam_role = "arn:aws:iam::${local.common_vars.account_id}:role/terragrunt"

remote_state {
  backend = "s3"

  config = {
    encrypt        = true
    bucket         = "${local.common_vars.account_alias}-terraform"
    region         = "us-east-1"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    acl            = "bucket-owner-full-control"
    dynamodb_table = "terraform"

    dynamodb_table_tags = {
      Provisioner = "terraform"
    }
  }
}

locals {
  common_vars = merge(yamldecode(file(find_in_parent_folders("account.yaml", "${get_parent_terragrunt_dir()}/empty.yaml"))))
  
}