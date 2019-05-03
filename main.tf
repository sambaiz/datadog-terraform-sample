terraform {
  backend "s3" {
    bucket  = "my-datadog-terraform"
    key     = "datadog-terraform.tfstate"
    region  = "ap-northeast-1"
    profile = "<your aws profile>"
  }
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "<your aws profile>"
}

provider "datadog" {
  api_key = "<datadog api key>"
  app_key = "<datadog app key>"
}

module "aws-integration" {
  source         = "./aws-integration"
  aws_account_id = "<your aws account id>"
}

module "lambda" {
  source = "./lambda"
}
