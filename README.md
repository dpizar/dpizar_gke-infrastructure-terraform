# Instructions
Pull the terraform docker image from the repository. We will run our terraform infrastructure on this image.
Run terraform docker image. **You need to explicitly define the directory with the terraform files when running the terraform container.**
```
docker image pull dpizar/terraformers:v1
docker run --rm -it -v "$(pwd):/terraformfiles" terraformers:v1 init // this run the image and initialize our infrastructure under the specified directory.
```

## Create infrastructure

# Create a Service account
Create a service account with storage.admin role and add it to the /common/bucket/ folder. On google cloud enable the Cloud Storage API.

# Configure Bucket
Configure a GCP Bucket so we can store the state of our infrastructure. Each folder in the terraform structure will have it's own independent state(This helps to encapsulate different parts of our infrastructure).
Go to the /common/bucket folder and run the terraform code.

We can either build the infrastructure using local modules or we can build it using the modules from Terraform Cloud Registry.
# Using local Modules
**Steps**
1. Navigate to the folder 'run-modules-local'
2. Run the terraform commands init, plan, apply. 
3. Run terraform command destroy if needed. (Run this command when doing testings to avoid unnecessary or accidental **fees** :heavy_dollar_sign: :heavy_dollar_sign:)

# Using Cloud Registry Modules
**Steps**
1. Navigate to the folder 'run-modules'
2. Run the terraform commands init, plan, apply. 
3. Run terraform command destroy if needed. (Run this command when doing testings to avoid unnecessary or accidental **fees** :heavy_dollar_sign: :heavy_dollar_sign:)