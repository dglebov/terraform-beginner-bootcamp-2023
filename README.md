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
So here is the latest changes:
[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli )

### Coonsidering for Linux Distribution

This project is built against Ubuntu.
Please consider checking your Linux Distribution and change accordingly:
[How to check linux version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/ )

### Refactoring into Bash scripts  
While fixing the Terraform CLI gpg deprecation issue, we noticed that bash script steps were a considerable amount more code. Se we decided to create a bash script to install the Terraform CLI. 

The bash script is located here: [./bin/install_terrafrom_cli](./bin/install_terrafrom_cli.sh)

- This will keep the Gitpod Task Fire tidy ([.gitpod.yml](.gitpod.yml))
- This will allow us an easier-to-debug 
- This will allow better portability for other projects. 


https://www.gitpod.io/docs/configure/workspaces/tasks 

#### Shebang
https://en.wikipedia.org/wiki/Shebang_(Unix) 
