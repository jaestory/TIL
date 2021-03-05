terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

  backend "s3" {
    key                  = "terraform/infra-config.tfstate"
    workspace_key_prefix = "infra"
    region               = "ap-northeast-2"
    encrypt              = true
    dynamodb_table       = "iterraform-state-lock"
  }
}

provider "aws" {
  region = "ap-northeast-2"
}
