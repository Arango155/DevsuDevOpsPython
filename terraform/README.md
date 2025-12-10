# Terraform IaC – DigitalOcean Kubernetes Cluster 

This folder contains the full Infrastructure-as-Code (IaC) configuration to create
a production-ready Kubernetes cluster in DigitalOcean.

##  Important
This IaC is included for evaluation purposes only and is not intended to be executed,
so no infrastructure will be provisioned and no cost will be generated.

## Files
- `provider.tf` → Terraform & provider configuration
- `variables.tf` → Inputs such as token, cluster name, region
- `main.tf` → Kubernetes cluster definition
- `outputs.tf` → Kubeconfig output

## Usage 

```bash
cd terraform/
terraform init
terraform plan
terraform apply
