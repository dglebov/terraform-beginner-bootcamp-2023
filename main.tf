terraform {
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "dglebov_org"#
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "dglebov_org"
    workspaces {
      name = "terra-house-1"
    }
  }
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}
provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 32
  lower            = true
  upper            = false
  special          = false
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}