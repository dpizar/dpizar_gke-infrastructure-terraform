# Automatically Deploy Terraform Infrastructure

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
We use our docker image(dpizar/terraformers:v4) to initialize, plan and apply our terraform infrastructure.

We can either build the infrastructure using local modules or we can build it using the modules from Terraform Cloud Registry.

## Using Terraformers Remote Modules stored in Terraform Cloud
Terraformers Modules for VPC and GKE are automatically updated to the terraform cloud if a change is detected. In this case we need to copy the new versions to our code in the **run-modules** folder.
We use the workflow gke_infrastructure_flow to automatically deploy our infrastructure to out GCP. 
### Secrets
First we need to set up our secrets containing out Docker credentials.
DOCKER_USER -- set your DockerHub account user
DOCKER_PASSWORD -- set yout Dockerhub account password

Now we need to store our GCP credentials in a secret. We need the whole .json file. But first we need to delete any newline, put every string inside quotes and escape double-quotes with double-quotes. e.g. hello = "abc"  ==> ""hello"" = ""abc""
For removing newlines follow instructions at: https://www.haigmail.com/2019/10/07/setting-up-google_credentials-for-terraform-cloud/.
Then add and escape double-quotes.
GCP_CREDENTIAL -- GCP Service Account key .json

Finally we need to store our terraform cloud credentials to use terraformers remote VPC and GKE modules. Got to https://app.terraform.io/app/Terraformers21/workspaces and create your credentials. Follow the same steps as for the GCP credentials to format it and store it as a secret.
TERRAFORM_CREDENTIAL -- .terraformrc file content

### Setting up Github environments
The workflow for deploying the terraform infrastructure contains two environments dev and prod. Create these environments for the repository on GitHub and add an approval process for the prod environment.

### Deploy infrastructure
Run the GKE Infrastructure workflow manually. 
Go to your GCP account and the infrastructure should have been deployed there.


# Deploying Terraform Infrastructure Manually Instructions
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

## Manually Deploying real world application
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