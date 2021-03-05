locals {
  config_base = {
    account = {
      dev  : "123456789012",
      prod : "123456789012"
    }
    role_name = {
      dev  : "dev-iam-role",
      prod : "prod-iam-role"
    }
  }

  config = {
    env = terraform.workspace
    az = {
      "2a" : "ap-northeast-2a",
      "2b" : "ap-northeast-2b",
      "2c" : "ap-northeast-2c",
      "2d" : "ap-northeast-2d"
    }
    tags = {
      Environment : terraform.workspace
    }
    account             = local.config_base.account[terraform.workspace]
    role_name           = local.config_base.role_name[terraform.workspace]
  }
}

output "config" { value = local.config }