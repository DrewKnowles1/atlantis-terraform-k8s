terraform {
  backend "gcs" {
    bucket  = "atlantis-tf-state-dev-cp"
    prefix  = "terraform/state"
  }
}


