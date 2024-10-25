data "nhncloud_compute_flavor_v2" "m2c1m2"{
  name = "m2.c1m2"
}

data "nhncloud_images_image_v2" "ubuntu_22" {
  name = "Ubuntu Server 22.04.4 LTS (2024.08.20)"
}

data "nhncloud_images_image_v2" "ubuntu_mariadb" {
  name = "Ubuntu Server 20.04.6 LTS with MariaDB 10.11.7 (2024.04.23)"
}