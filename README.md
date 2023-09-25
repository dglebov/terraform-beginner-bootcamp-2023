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
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli )

### Considering for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly:
[How to check Linux version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/ )

### Refactoring into Bash scripts  
While fixing the Terraform CLI gpg deprecation issue, we noticed that bash script steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI. 

The bash script is located here: [./bin/install_terrafrom_cli](./bin/install_terrafrom_cli.sh)

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

We can filter specifit env vars using `grep` e.g. `env | Grep AWS_`

#### Setting and Unsetting Env Vars 

In the terminal: `export Hello='word'`
To unset in the terminal: `unset Hello`

We can set an env vars temporarily when just runng a command

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

We can print env vars using echo eg `echo $HELLO`


### Scoping of Env Vars 

When you open up a new bash terminals in VSCode it will not be aware of env vars that you have set in another window. 

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profice. eg. `.bash_profile`

#### Persisting Env Vars in Gitpod 

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage 

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in thoes workspaces 

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars. 


### AWS CLI Installation 

AWS CLI is installed fro the project vie the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


[Getting started with AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
[AWS ENV VARS](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS crediantial are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

If it is succesful you shiuld see a json payload return:

```json
{
    "UserId": "AAF24SQ3AS1FYBBJC54OR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terrafrom-beginner-bootcamp"
}
```

We'll need to generate AWS CLI crediantial from IAM USer in order to use AWS CLI