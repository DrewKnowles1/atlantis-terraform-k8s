terraform {
  backend "gcs" {
    bucket  = "atlantis-engineering-playground-tf-state"
    prefix  = "terraform/engineering-playground/state"
  }
}


