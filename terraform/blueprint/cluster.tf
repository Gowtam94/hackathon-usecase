resource "google_container_cluster" "rod-cluster" {
  name     = var.cluster_name
  location = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  default_max_pods_per_node = 24
  network = var.network
  subnetwork = var.subnetwork
  deletion_protection = false
  ip_allocation_policy{
   cluster_secondary_range_name= Pods
   services_secondary_range_name= Services
  cluster_autoscaling{}
  master_auth{}
  workload_identity-config()
  private_ip_config{}

  

# Default node pool
resource "google_container_node_pool" "rod-nodes" {
  name       = "${var.cluster_name}-pool"
  cluster    = google_container_cluster.rod-clsuter.name
  location   = var.region
  node_count = var.node_count

  node_config {
    machine_type = "e2-medium"
    image_type = cos-containerd
    disk_type = pd-balanced
    disk_size_gb= 300
    cpu_platform= AMD Milan
    min_count= 0
    max_count= 200
    premitible= true
    os = windows
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # Auto-upgrade & repair
  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
