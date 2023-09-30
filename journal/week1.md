# Terraform Beginner Bootcamp 2023 - Week 1 


## Root Module Structure

Our root module structure is as follows:
```
PROJECT_ROOT
|-- main.tf - everything else
|-- variables.tf - stores the structure of input variables
|-- provider.tf - defines required providers
|-- outputs.tf - stores our output
|-- terraform.tfvars - the data of variables we want to load into our terraform project
|-- README.MD - required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and input variables

### Terraform Cloud Variables 

In Terraform we can set two kind of wariables:
- Enviroment variables - those you would set in your bash terminal 
- Terraform Variables - those that you would normally set in your tfvars file 

We can set TF Cloud variables to be sensetive. 

### Loading Terraform Input variables

[Documetation link for Terraform input variables](https://developer.hashicorp.com/terraform/language/values/variables)

#### var flag
We can use `-var` flag to set an inout variable or override a variable 

#### var-file flag 


### terraform.tfvars

This is the defauls file to load in terraform variables in blunk 

### auto.tfvars 


### order of terraform variables 


## Terrafrom configuration Drift 

If you lose your state file you most likly have to tear down all your cloud infrastructure manually.

You can use terrafrom port but it won't for all cloud resoures., You need to check provider's documentation for which resoures support import. 

### Fix missing resoures with Terraform Import 

`terraform import aws_s3_bucket.bucket bucket-name`

[Terrafom Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)


### Fix Manual Configuration

If someone goes and deletes or modifies cloud resoures manually through ClickOps 

If we run `Terrafom plan` is with attempt to put our infrastructure bacj into the expected state fixing Configuratio Drift 

### Fix using Terraform refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules 

### Terraform Modules Structure

It is recomended to place modules in a `modules` directory when locally developing modules, but that is not a hard rule. 

### Passing Input Variables 

We can pass input variables to our modules.
The module has to declare in its own `variables.tf`

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Modules Sources 

[Modules Sources ](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

Using the source we can import the module from variuos places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```



## Consideration when using ChatGPT

LLMs may not be trained on the latest documentation. May use docs that could be deprecated.

## Working with Files in Terraform

### Fileexists function

This is a built in terraform function to check the existance of a file.

```tf
condition = fileexists(var.error_html_filepath)
```

https://developer.hashicorp.com/terraform/language/functions/fileexists

### Filemd5

https://developer.hashicorp.com/terraform/language/functions/filemd5

### Path Variable
In TF there is a spetial variable called `path` to reference local paths:

- path.module = get the path fro the current module 
- path.root = get the path for the root module 

[Spetial Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

