#!/bin/bash
git clone https://github.com/dpizar/dpizar_gke-infrastructure-terraform.git

cd dpizar_gke-infrastructure-terraform/run-modules/
# We need the .tfvars we passed as secrets in the same directory as the terraform code. Use -f to replace the file if it exists
cp /terraformfiles/terraform.tfvars /terraformfiles/dpizar_gke-infrastructure-terraform/run-modules/terraform.tfvars -f

terraform init
terraform apply -auto-approve