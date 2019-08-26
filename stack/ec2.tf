
data "template_file" "user-data" {
  template = "${file("${path.module}/user-data/jenkins-master.sh")}"
}


module "jenkins-master" {
  source = "../modules/aws-ec2-instance"

  instance_count = 1

  name          = "Jenkins-Master"
  ami           = data.aws_ami.amazon-linux.id
  instance_type = "t2.micro"
  subnet_ids    = module.eks-cluster.public_subnets
  key_name      = "ci-stack"
  user_data    = "${data.template_file.user-data.rendered}"
  //  private_ips             = ["172.31.32.5", "172.31.46.20"]
  vpc_security_group_ids      = [module.jenkins-master-sg.this_security_group_id]
  associate_public_ip_address = true
  //   placement_group        = aws_placement_group.web.id

  root_block_device = [
    {
      volume_type = "gp2"
      volume_size = 20
    },
  ]

  tags = {
    "Owner"       = var.owner
    "Environment" = var.environment
    "Name"        = "Jenkins-Master-${var.stack_name}"
  }
}
