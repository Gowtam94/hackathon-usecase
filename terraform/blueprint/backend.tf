terraform {
  backend "gcs" {
    bucket  = "state-bucket"   
    prefix  = "terraform/terraform.tfstate" 
    project     = "rod-12345-dev-f2"
    credentials = "gcspath/service-account.json"
  }
}
