terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.16.0"
    }
  }
}

provider "google" {
  credentials = file(var.credentials)
  project = var.project
  region  = var.region
}



resource "google_storage_bucket" "module_1_bucket" {
  name          = var.gcs_bucket_name
  location      = var.location

  # Optional, but recommended settings:
  storage_class = var.gcs_storage_class
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30  // days
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "module_1_dataset" {
  dataset_id = var.bq_dataset_name
  project    = var.project
  location   = var.location
}
