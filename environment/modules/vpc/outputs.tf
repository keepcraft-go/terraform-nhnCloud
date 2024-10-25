output network_vpc_id {
    value = nhncloud_networking_vpc_v2.terraform_vpc.id
} 


output network_sub_pub_id {
    value = nhncloud_networking_vpcsubnet_v2.public_subnet.id
} 

