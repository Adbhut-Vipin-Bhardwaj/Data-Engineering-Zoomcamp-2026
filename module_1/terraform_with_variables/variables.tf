variable "credentials" {
  description = "My Credentials"
  default     = "/home/adbhut/Desktop/study_material/datatalks-club/data-engineering/keys/dtc-de-course-485117-2616c5567ed7.json"
}

variable "project" {
  description = "Project"
  default     = "dtc-de-course-485117"
}

variable "region" {
  description = "Region"
  default     = "asia-south1"
}

variable "location" {
  description = "Project Location"
  default     = "asia-south1"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "dtc_de_course_485117_module_1_dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  default     = "dtc-de-course-485117-module-1-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}
