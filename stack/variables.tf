
variable aws_region {
  default = "eu-west-1"
}

variable stack_name {
  default = "capstone"
}

variable environment {
  default = "development"
}

variable owner {
  default = "david@walton.io"
}


variable route53_zone_id {
  default = ""
  description = "Route53 DNS Zone ID"
}

variable ssl_cert_arn {
  default = "david@walton.io"
  description = "SSL Certificate ARN"
}


variable aws_access_key {
  default = ""
  description = "AWS Access Key ID"
}

variable aws_secret_key {
  default = ""
  description = "AWS Secret Key ID"
}
