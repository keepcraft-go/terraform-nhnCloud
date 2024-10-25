# Define required providers
terraform {
required_version = ">= 1.0.0"
  required_providers {
    nhncloud = {
      source  = "nhn-cloud/nhncloud"
      version = "1.0.2"
    }
  }
}
provider "nhncloud" {
  user_name   = var.nhncloud_info["user_name"]
  tenant_id   = var.nhncloud_info["tenant_id"]
  password    = var.passwd
  auth_url    = var.nhncloud_info["auth_url"]
  region      = var.region["kr2"]
}