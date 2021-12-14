#!/bin/ash
git clone https://github.com/dpizar/dpizar_gke-infrastructure-terraform.git

cd dpizar_gke-infrastructure-terraform/run-modules/
cp -r /terraformfiles/auth/ /terraformfiles/dpizar_gke-infrastructure-terraform/run-modules/

ls -a

terraform init
terraform apply -auto-approve
