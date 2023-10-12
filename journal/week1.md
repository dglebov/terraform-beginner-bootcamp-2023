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

## Terraform Locals

Locals allows us to define local variables.
It can be very useful when we need transform data into another format and have referenced a varaible.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

## Terrafrim Data Sources

This allows use to source data from cloud resources.

This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)


## Working with JSON

We use the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)



### Terraform Resoures - Changing the lifecycle 

[The lifecycle Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

(TF Data docs)[https://developer.hashicorp.com/terraform/language/resources/terraform-data]



## Provisioners

Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by Hashicorp because Configuration Management tools such as Ansible are a better fit, but the functionality exists.

[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

This will execute command on the machine running the terraform commands eg. plan apply

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```

https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as ssh to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```
https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec