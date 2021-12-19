# Instructions
Pull the terraform docker image from the repository. We will run our terraform infrastructure on this image.
Run terraform docker image. **You need to explicitly define the directory with the terraform files when running the terraform container.**
```
docker image pull dpizar/terraformers:v4


docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 init
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 plan -var-file="terraform.tfvars"
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 apply -var-file="terraform.tfvars"// this run the image and initialize our infrastructure under the specified directory.

To Destroy:
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 apply "-destroy" "-auto-approve"

```

# Create infrastructure

## Enable the following Google Cloud APIs
```
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com 
gcloud services enable cloudresourcemanager.googleapis.com
```

## Create a Service account
Create a service account with storage.admin role and add it to the /common/bucket/ folder. On google cloud enable the Cloud Storage API.

## Configure Bucket
Configure a GCP Bucket so we can store the state of our infrastructure. Each folder in the terraform structure will have it's own independent state(This helps to encapsulate different parts of our infrastructure).
Go to the /common/bucket folder and run the the terraform commands:
```
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 init
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 plan -var-file="terraform.tfvars"
docker run --rm -it -v "$(pwd):/terraformfiles" dpizar/terraformers:v4 apply -var-file="terraform.tfvars"
```
We use our docker image(dpizar/terraformers:v3) to initialize, plan and apply our terraform infrastructure.

We can either build the infrastructure using local modules or we can build it using the modules from Terraform Cloud Registry.
## Using local Modules(Tested and working)
**Steps**
1. Navigate to the folder 'run-modules-local'
2. Run the terraform commands init, plan, apply as seen above, with terraform.tfvars configuration file.
3. Run terraform command destroy if needed. (Run this command when doing testings to avoid unnecessary or accidental **fees** :heavy_dollar_sign: :heavy_dollar_sign:)

## Using Cloud Registry Modules(Tested and working)
**Before Steps**
1. Generate your Terraform Token and put it in create-gke folder
**Steps**
1. Navigate to the folder 'run-modules'
2. Go to https://app.terraform.io/app/Terraformers21/registry/private/modules and make sure we have the latest version of modgke(google k8 cluster module) and the modvpc(Networking module)
3. Run the terraform commands init, plan, apply as seen above, with terraform.tfvars configuration file.
4. Run terraform command destroy if needed. (Run this command when doing testings to avoid unnecessary or accidental **fees** :heavy_dollar_sign: :heavy_dollar_sign:)


## Deploying real world application
After out terraform infrastructure is up and running we can deploy our real world application.
Authenticate to cluster 
```
gcloud container clusters get-credentials gke-ycit-tformers-default-dev --region us-central1 
```

Navigate to folder reactReduxChart/
Create a namespace, switch to create namespace and deploy helm chart.
```
kubectl create ns dev
kubectl config set-context --current --namespace=dev

# install helm chart, make sure the name is lowercase
helm install reactreduxchart .
```