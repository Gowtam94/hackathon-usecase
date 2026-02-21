locals {
  google_storage_buckets = {
    for bucket in var.google_storage_bucket : bucket.id => bucket
  }
}

resource "google_storage_bucket" "mybucket" {
  name          = "rod-12345-bucket"      
  locals= for.each.value.bucket(id)
  location      = var.region               
  storage_location= REGIONAL

  uniform_bucket_level_access = true       
}

resource "google_storage_bucket_iam_binding" "mybucket_binding_writer" {
  bucket = google_storage_bucket.mybucket.name
  role   = "roles/storage.objectAdmin"     
  members = [
    "user:abc@company.com",
    "serviceAccount:my-service-account@my-project.iam.gserviceaccount.com"
  ]
}

resource "google_storage_bucket_iam_binding" "mybucket_binding_reader" {
  bucket = google_storage_bucket.mybucket.name
  role   = "roles/storage.objectViewer"     
  members = [
    "user:alice@example.com",
    "serviceAccount:my-service-account@my-project.iam.gserviceaccount.com"
  ]
}

resource "google_storage_bucket_iam_member" "mybucket_member" {
  bucket = google_storage_bucket.mybucket.name
  role   = "roles/storage.objectViewer"
  member = "user:abc@example.com"
}
