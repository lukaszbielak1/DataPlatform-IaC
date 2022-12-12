# Introduction
This is the Azure Data Platform Infrastructure proposition.

# File Description
**azure-pipelines.yml** - the Azure Devops pipeline definition that includes several steps. 
1. Replace the tokens with secret values
2. Installs the terraform on Azure Devops Agent
3. Initialize terraform using the backend configuration
4. Run terraform plan command
5. Apply the changes

**backend.conf** - contains the backend storage account config\
**dev.tfvars** - contains all values for the dev environment\
**main.tf** - the main file with all resources\
**variables.tf**- all variables definition
