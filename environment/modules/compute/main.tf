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

resource "nhncloud_compute_instance_v2" "web_server" {
  name      = var.instance_name
  key_pair  = var.key_pair
  flavor_id = data.nhncloud_compute_flavor_v2.m2c1m2.id
  security_groups = ["default"]

  network {
    port = nhncloud_networking_port_v2.port_1.id
  }
    user_data = "#include https://kr2-api-object-storage.nhncloudservice.com/v1/AUTH_cf5a0f8add884a61a2f047ff8c16c4bb/real-iac-terraform/terra-index.txt" #사용자스크립트 

  block_device {
    uuid                  = data.nhncloud_images_image_v2.ubuntu_22.id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = 20
    delete_on_termination = true
  }
}

resource "nhncloud_networking_port_v2" "port_1" {
  name = var.nic_name
  network_id = var.network_id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = var.subnet_id
  } 
}