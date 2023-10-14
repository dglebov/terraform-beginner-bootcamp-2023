terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "dglebov_org"#
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  # }
 cloud {
   organization = "dglebov_org"
   workspaces {
     name = "terra-house-1"
   }
 }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.user_uuid
  token = var.terratowns_token
}

module "home_fallout_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.user_uuid
  public_path = var.fallout.public_path
  content_version = var.fallout.content_version
}

resource "terratowns_home" "home" {
  name = "Why Fallout is the best game ever?"
  description = <<DESCRIPTION
Fallout is the RPG from 1997 and it's simply the best. Please try it! 
DESCRIPTION
  domain_name = module.home_fallout_hosting.domain_name
  #  domain_name = "23523gg215.cloudfront.net"
  town = "gamers-grotto"
  content_version = var.fallout.content_version
}

module "home_borch_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.user_uuid
  public_path = var.borch.public_path
  content_version = var.borch.content_version
}

resource "terratowns_home" "Borch" {
  name = "Making Borch"
  description = <<DESCRIPTION
I adore Borch (Slavic red soup, a famous dish in Ukraine). Here is my recipe. 
DESCRIPTION
  domain_name = module.home_borch_hosting.domain_name
  town = "cooker-cove"
  content_version = var.borch.content_version
}