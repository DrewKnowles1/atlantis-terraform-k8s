terraform {
  backend "gcs" {
    bucket  = "atlantis-tf-state-dev-cp"
    prefix  = "terraform/state"
    credentials = "/home/aknow/tf/clean-patrol-311410-0a2251d78e02.json"
  }
}


