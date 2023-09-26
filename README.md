# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:


This project is going to utilize semantic versioning for its tagging [semver.org](https://semver.org/)

The general format:
 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

**MAJOR** version when you make incompatible API changes
**MINOR** version when you add functionality in a backward-compatible manner
**PATCH** version when you make backward-compatible bug fixes

## Install the Terrafom CLI 
### Considerations with the Terraform CLI changes 
The Terraform CLI installation instructions have changed due to gpg keyring changes. 
So here are the latest changes:
[Install Terraform CLI](https://developer.hashicorp.com/Terraform/tutorials/aws-get-started/install-cli )

### Considering Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly:
[How to check Linux version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/ )

### Refactoring into Bash scripts  
While fixing the Terraform CLI gpg deprecation issue, we noticed that bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI. 

The bash script is located here: [./bin/install_Terraform_cli](./bin/install_Terraform_cli.sh)

- This will keep the Gitpod Task Fire tidy ([.gitpod.yml](.gitpod.yml))
- This will allow us an easier-to-debug 
- This will allow better portability for other projects. 

#### Gitpod Lifecycle
We must be careful when using the Init because it will not rerun if we restart an existing workspace.
https://www.gitpod.io/docs/configure/workspaces/tasks 

#### Shebang
https://en.wikipedia.org/wiki/Shebang_(Unix) 



### Working with ENV Vars 

We can list out all Env Vars using the `env` command 

We can filter specific env vars using `grep`, e.g. `env | Grep AWS_`

#### Setting and Unsetting Env Vars 

In the terminal: `export Hello='word'`
To unset in the terminal: `unset Hello`

We can set an env vars temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Withing a bash script we can sen env without using export eg.
```sh 
#!/usr/bin/env bash
Hello='world'

echo $HELLO
```

#### Printing Vars 

We can print env vars using echo e.g. `echo $HELLO`


### Scoping of Env Vars 

When you open up a new bash terminal in VSCode it will not be aware of env vars that you have set in another window. 

If you want Env Vars to persist across all future bash terminals that are open, you need to set env vars in your bash profile. e.g. `.bash_profile`

#### Persisting Env Vars in Gitpod 

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage 

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces 

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars. 


### AWS CLI Installation 

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting started with AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a JSON payload return:

```json
{
    "UserId": "AAF24SQ3AS1FYBBJC54OR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/Terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credentials from IAM user in order to use AWS CLI



# Terraform Basics 

### Terraform Registry

TF sources their providers and modules fromt the Terraform registry which located at [registry terrafom.io](https://registry.Terraform.io/)

- **Provider** is interface to APIs that will aloow you to create resoures in TF
- **Modules** are a way to make ladge amounts of TF code modular, portable and shareble. 

[Random TF provider](https://registry.Terraform.io/providers/hashicorp/random/)
## Terraform Console 

We can see a list of all the RF command by typing `Terraform`

#### Terraform Init 
At the start of a new project we will run `Terraform init` to download the binaries for the Terraform providers 

#### Terraform Plan 
`Terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed. 

#### Terraform Apply 
`Terraform apply`
This will run a plan and pass the changeset to be executed by Terraform. Apply should prompt us yes or nor. 

If we want to automatically approve an apply we can provide auto aprove flag - `Terraform apply --auto-approve`

#### Terraform Destroy 

`terraform destroy --auto-approve`
This will destroy resoures. 

#### Terraform Lock Files 

`.terraform.lock.hcl` contains the locked version for the providers or modules that should be used with this project 

The Terrafrom lock file **should be commited** to your Version Control System (VCS) eg. Github

#### Terraform State Files 

`terraform.tfstate` contains infromation about the current state of your infrastructure 

This file **should not be commited** to your VCS

If you lose this file, you lose knowing the state of your infrastructure

`.terraform.tfstate.backup` is the previous state file state.

#### Terrafrom Directory

`.terrafrom` directory contains binaries of terraform providers.