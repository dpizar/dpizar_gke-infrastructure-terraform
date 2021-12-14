#!/bin/ash
git clone https://github.com/dpizar/dpizar_gke-infrastructure-terraform.git

cd dpizar_gke-infrastructure-terraform/run-modules/

terraform init
terraform apply -auto-approve