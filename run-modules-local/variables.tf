# GCP authentication file
variable "gcp_auth_file" {
  type        = string
  description = "GCP authentication file for the GCP service account key in JSON format"
  default     = "./terraform-svc.json"
}

variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "billing_account" {
  type        = string
  description = "The billing account associated to the project"
}

variable "gcp_region" {
  type        = string
  description = "The GCP Region where elements will be created"
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "The GCP Zone where elements will be created"
  default     = "us-central1-c"
}

variable "org" {
  type        = string
  description = "The organisation name to tied the computre resource - for academic purposes it can be student initials"
  default     = "ycit"
}

variable "environment" {
  type        = string
  description = "The prefix to add to object names indicating the environment intended when create"
  default     = "dev"
}

variable "pods_cidr_name" {
  type        = string
  description = "The pods CIDR name"
  default     = "pods"
}

variable "initial_node_count" {
  type        = number
  description = "The minimum node count for the cluster"
  default     = 1
}

variable "bucket_name" {
  description = "GCS Bucket name. Value should be unique."
  type        = string
  default     = "tf-bucket-ycit021"
}