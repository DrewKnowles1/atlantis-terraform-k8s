terraform {   
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {

  credentials = file("/home/aknow/tf/clean-patrol-311410-0a2251d78e02.json")

  project = "clean-patrol-311410"
  region  = "europe-west2"
  zone    = "europe-west2-b"
}

resource "google_compute_network" "vpc_network" {
  name = "engineering-playground-network"
}

resource "google_container_cluster" "engineering_playground_cluster" {
  name               = "engineering-playground-cluster"
  location           = "europe-west2"
  remove_default_node_pool = true
  initial_node_count = 1

  network    = "engineering-playground-network"
  subnetwork = "engineering-playground-network"

  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/16"
    services_ipv4_cidr_block = "/22"
  }
   depends_on = [
    google_compute_network.vpc_network,
  ]
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "engineering-playground-cluster-nodepool"
  location   = "europe-west2"
  cluster    = google_container_cluster.engineering_playground_cluster.name
  node_count = 1

  node_config {
    ##Trying to save some pennies
    preemptible  = true
    machine_type = "n2d-standard-2"
  }
  depends_on = [
    google_container_cluster.engineering_playground_cluster,
  ]
}