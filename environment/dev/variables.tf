variable nhncloud_info {
  type        = map(string)
  default     = {
    user_name = "xxxxxxx@xxxxxxx.com"
    tenant_id = "xxxxxxxxx"
    auth_url = "https://api-identity-infrastructure.nhncloudservice.com/v2.0"
  }
}

variable passwd {
    type = string
    default = "test"
    sensitive =true

}

variable region {
    type = map(string)
    default = {
        kr1 = "KR1"
        kr2 = "KR2"
    }
}