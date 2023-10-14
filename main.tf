terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "dglebov_org"#
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
 # cloud {
 #   organization = "dglebov_org"
 #   workspaces {
 #     name = "terra-house-1"
 #   }
 # }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token = var.terratowns_token
}

module "terrahouse_aws" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.user_uuid
 bucket_name = var.bucket_name
 index_html_filepath = var.index_html_filepath
 error_html_filepath = var.error_html_filepath
 content_version = var.content_version
 assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Why Fallous is the best game ever?"
  description = <<DESCRIPTION
Fallout is the RPG from 1997 and it's simply the best. Please try it! 
DESCRIPTION
   domain_name = module.terrahouse_aws.cloudfront_url
  #  domain_name = "23523gg215.cloudfront.net"
  town = "missingo"
  content_version = 1
}