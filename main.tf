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
  region  = "eu-west1"
  zone    = "eu-west1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
