required_providers {
  google = {
    source = "hashicorp/google"
    version = "3.5.0"
  }
}

provider "google" {

  credentials = file("/home/aknow/tf/clean-patrol-311410-0a2251d78e02.json")

  project = "My First Project"
  region  = "eu-west2"
  zone    = "eu-west2-b"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
