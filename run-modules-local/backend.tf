# The block below configures backend to use the 'GCS' bucket.
# variables or functions cannot be used.
# validate values match your environment. 
# specially the bucket value, it should match the bucket you created in GCP. 

terraform {
  backend "gcs" {
    bucket      = "dpizar_terraform_state"
    prefix      = "terraform/local-module-state"
    credentials = "./auth/terraform-svc.json"
  }
}
