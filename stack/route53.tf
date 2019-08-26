

data "aws_route53_zone" "pools-ac" {
  name         = "pools.ac"
  private_zone = false
}

resource "aws_route53_record" "jenkins-record" {
  zone_id = "${data.aws_route53_zone.pools-ac.zone_id}"
  name    = "jenkins.${data.aws_route53_zone.pools-ac.name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${module.jenkins-master-alb.dns_name}"]
}
