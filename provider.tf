terraform {
  required_version = ">= 1.3.7"

  required_providers {
    oci = {
      version = "6.26.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.4"
    }
  }

}

provider "oci" {
  user_ocid        = var.user
  fingerprint      = var.fingerprint
  tenancy_ocid     = var.tenancy
  region           = var.region
  private_key_path = var.key_file
}