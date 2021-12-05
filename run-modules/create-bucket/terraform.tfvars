# Values for variables used by terraform
#
# Update values with your environment
#

# GCP Seettings

gcp_auth_file         = "./auth/terraform-svc.json"        			#File with service account Key in json format 
gcp_project_id        = "dpizar-notepad-dev-1"         						#Project ID, not the name the Project Id
billing_account       = "010227-F277BC-AFD307"     							#billing account tied to the project Id

gcp_region      = "us-central1"
gcp_zone              = "us-central1-a"

environment     = "dev"                       #value to be prefixed to resources names to differentiate them

# Bucket

bucket_name           = "dpizar_terraform_state"					# Put the desired GCS Bucket name.
force_destroy       = true
versioning_enabled  = true
storage-class       = "REGIONAL"
