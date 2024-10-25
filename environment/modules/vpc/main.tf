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

#VPC 생성 리소스 블록 
resource "nhncloud_networking_vpc_v2" "terraform_vpc" {
  name = var.vpc_name
  cidrv4 = var.vpc_cidr
}

resource "nhncloud_networking_vpcsubnet_v2" "public_subnet" {
  name      = var.pub_name
  vpc_id    = nhncloud_networking_vpc_v2.terraform_vpc.id
  cidr      = var.pub_cidr
}

resource "nhncloud_networking_vpcsubnet_v2" "private_subnet" {
  name      = var.pri_name
  vpc_id    = nhncloud_networking_vpc_v2.terraform_vpc.id
  cidr      = var.pri_cidr
}