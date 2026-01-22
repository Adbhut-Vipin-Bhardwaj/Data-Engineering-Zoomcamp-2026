terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.16.0"
    }
  }
}

provider "google" {
# Credentials only needs to be set if you do not have the GOOGLE_APPLICATION_CREDENTIALS set
#  credentials = 
  project = "dtc-de-course-485117"
  region  = "asia-south1"
}



resource "google_storage_bucket" "module_1_bucket" {
  name          = "dtc-de-course-485117-module-1-bucket"
  location      = "asia-south1"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
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
  dataset_id = "dtc_de_course_485117_module_1_dataset"
  project    = "dtc-de-course-485117"
  location   = "asia-south1"
}
