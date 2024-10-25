variable vpc_name {
    type = string
    default = "terra_vpc"
}

variable vpc_cidr {
    type = string
    default = "192.168.0.0/16"
    
}

variable pub_name {
    type = string
    default = "public_subnet"
}

variable pub_cidr {
    type = string
}

variable pri_name {
    type = string
    default = "private_subnet"
}

variable pri_cidr {
    type = string
}
