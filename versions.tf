# version.tf

terraform {
  required_version = ">= 0.13.1"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.57"
    }
  }
}
