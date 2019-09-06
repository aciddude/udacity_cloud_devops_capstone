

## Get AWS Availability Zones
data "aws_availability_zones" "available" {
  state = "available"
}

## Get Latest Amazon Linux 2 AMI
data "aws_ami" "amazon-linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }
}


### Write k8s data

data "template_file" "alb-ingress-controller" {
  template = "${file("${path.module}/k8s-templates/alb-ingress-controller.tpl")}"
  vars = {
    cluster_name   = "${var.stack_name}-eks-cluster",
    vpc_id         =  module.eks-cluster.vpc_id,
    aws_region     = "${var.aws_region}",
    aws_access_key = "${var.aws_access_key}",
    aws_secret_key = "${var.aws_secret_key}"
  }
}

resource "local_file" "alb-ingress-controller" {
    content     = "${data.template_file.alb-ingress-controller.rendered}"
    filename = "${path.module}/k8s-templates/alb-ingress-controller.yml"
}


data "template_file" "webapp-ingress" {
  template = "${file("${path.module}/k8s-templates/webapp-ingress.tpl")}"
  vars = {
    cluster_name   = "${var.stack_name}-eks-cluster",
    public_subnets = "${join(",",  module.eks-cluster.public_subnets)}"
  }
}

resource "local_file" "webapp-ingress" {
    content     = "${data.template_file.webapp-ingress.rendered}"
    filename = "${path.module}/k8s-templates/webapp/webapp-ingress.yml"
}


data "template_file" "external-dns" {
  template = "${file("${path.module}/k8s-templates/external-dns.tpl")}"
  vars = {
    domain   = "${var.domain}"
  }
}

resource "local_file" "external-dns" {
    content     = "${data.template_file.external-dns.rendered}"
    filename = "${path.module}/k8s-templates/external-dns.yml"
}
