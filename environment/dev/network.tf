module vpc {
    source = "../modules/vpc"
    vpc_name = "module-test-vpc"
    vpc_cidr = "10.0.0.0/16"
    pub_cidr = "10.0.1.0/24"
    pri_cidr = "10.0.2.0/24"
}

resource "nhncloud_networking_routingtable_v2" "private_rt" {
  name = "private_rt"
  vpc_id = module.vpc.network_vpc_id
  distributed = false
}

module comptue {
    source = "../modules/compute"

    instance_name = "terra_instance"
    key_pair = "nhn-key-pair-pyengchon"
    nic_name = "terra-port"
    network_id = module.vpc.network_vpc_id
    subnet_id = module.vpc.network_sub_pub_id

}
