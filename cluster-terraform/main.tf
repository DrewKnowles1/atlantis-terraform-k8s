provider "google-beta" {

  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = "engineering-playground-network"
  project = var.project_id
}

resource "google_container_cluster" "engineering_playground_cluster" {
  provider = google-beta
  name               = "engineering-playground-cluster"
  location           = var.region
  remove_default_node_pool = true
  initial_node_count = 1

  network    = "engineering-playground-network"
  subnetwork = "engineering-playground-network"
  
  # Enable Workload Identity
  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }


  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }
   depends_on = [
    google_compute_network.vpc_network,
  ]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  provider = google-beta
  name       = "engineering-playground-cluster-nodepool"
  location   = var.region
  cluster    = google_container_cluster.engineering_playground_cluster.name
  node_count = 1
  
  node_config {
    ##Trying to save some pennies
    preemptible  = true
    machine_type = var.machine_type
    

    workload_metadata_config {
      node_metadata = "GKE_METADATA_SERVER" 
    }

  }
  depends_on = [
    google_container_cluster.engineering_playground_cluster,
  ]
}
