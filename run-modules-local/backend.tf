# The block below configures backend to use the 'GCS' bucket.
# variables or functions cannot be used.
# validate values match your environment. 
# specially the bucket value, it should match the bucket you created in GCP. 

terraform {
  backend "gcs" {
    bucket      = "dpizar_terraform_state"
    prefix      = "terraform/local-module-state"
<<<<<<< HEAD
    credentials = "../common/auth/terraform-svc.json"
=======
    credentials = "./auth/terraform-svc.json"
>>>>>>> 079ab9d (Changes for running terraform in docker container)
  }
}
