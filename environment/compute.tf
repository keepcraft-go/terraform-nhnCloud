resource "nhncloud_compute_instance_v2" "web_server" {
  name      = "web_server"
  key_pair  = "nhn-key-pair-pyengchon"
  flavor_id = data.nhncloud_compute_flavor_v2.m2c1m2.id
  security_groups = ["default","web-sg"]

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
  name = "tf_port_1"
  network_id = nhncloud_networking_vpc_v2.terraform_vpc.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = nhncloud_networking_vpcsubnet_v2.public_subnet.id	
  } 
}

resource "nhncloud_networking_secgroup_v2" "web-sg" {
  name = "web-sg"
}

resource "nhncloud_networking_secgroup_rule_v2" "web_sg-rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = nhncloud_networking_secgroup_v2.web-sg.id
  depends_on= [nhncloud_networking_secgroup_v2.web-sg]
}


#floating IP 생성 
resource "nhncloud_networking_floatingip_v2" "fip_01" {
  pool = "Public Network"
}

#floating IP 연결  
resource "nhncloud_networking_floatingip_associate_v2" "fip_associate" {
  floating_ip = nhncloud_networking_floatingip_v2.fip_01.address #생성한 Floating IP 
  port_id = nhncloud_networking_port_v2.port_1.id #floating IP 연결한 네트워크 포트 id 값 가져오기 
}


resource "nhncloud_compute_instance_v2" "db_server" {
  name      = "db_server"
  key_pair  = "nhn-key-pair-pyengchon"
  flavor_id = data.nhncloud_compute_flavor_v2.m2c1m2.id
  security_groups = ["db-sg"]

  network {
    port = nhncloud_networking_port_v2.port_2.id
  }

  user_data = "#include https://nh.nu/5mxkq"

    block_device {
    uuid                  = data.nhncloud_images_image_v2.ubuntu_mariadb.id
    source_type           = "image"
    destination_type      = "volume"
    boot_index            = 0
    volume_size           = 20
    delete_on_termination = true
  }
}

resource "nhncloud_networking_secgroup_v2" "db-sg" {
  name      = "db-sg"
}


resource "nhncloud_networking_secgroup_rule_v2" "db_sg-rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 3306
  port_range_max    = 3306
  remote_ip_prefix  = "10.0.1.0/24"
  security_group_id = nhncloud_networking_secgroup_v2.db-sg.id
}
resource "nhncloud_networking_port_v2" "port_2" {
  name = "tf_port_2"
  network_id = nhncloud_networking_vpc_v2.terraform_vpc.id
  admin_state_up = "true"
  fixed_ip {
    subnet_id = nhncloud_networking_vpcsubnet_v2.private_subnet.id	
  } 
  security_group_ids  = [nhncloud_networking_secgroup_v2.db-sg.id]
}
