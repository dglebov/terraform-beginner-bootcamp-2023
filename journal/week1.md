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

