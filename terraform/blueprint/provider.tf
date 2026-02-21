
  provider "google" {
  version = "4.4.1"
}

provider "google-beta" {
  version = "4.4.1"
}

data "google_client_config" "default" {}

data "google_container_cluster" "mycluster" {
  name    = var.cluster_name
  region  = var.region
  project = var.project
}

kubernetes {
  host                   = data.google_container_cluster.mycluster.endpoint
  token                  = data.google_client_config.default.token
  client_certificate     = base64decode(data.google_container_cluster.mycluster.master_auth.0.client_certificate)
  client_key             = base64decode(data.google_container_cluster.mycluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(data.google_container_cluster.mycluster.master_auth.0.cluster_ca_certificate)
}

vault {
  skip_child_token = true
  address          = var.vault_address
}
 
