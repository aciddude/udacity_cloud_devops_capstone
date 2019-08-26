### EKS cluster

module "eks-cluster" {
  source  = "../modules/aws-eks"

  aws-region          = "${var.aws_region}"
  availability-zones  = "${data.aws_availability_zones.available.names}"
  cluster-name        = "${var.stack_name}-eks-cluster"
  k8s-version         = "1.13"
  node-instance-type  = "t3.medium"
  root-block-size     = "40"
  desired-capacity    = "3"
  max-size            = "4"
  min-size            = "1"
  public-min-size     = "0" # setting to 0 will create the launch config etc, but no nodes will deploy"
  public-max-size     = "0"
  public-desired-capacity = "0"
  vpc-subnet-cidr     = "10.0.0.0/16"
  private-subnet-cidr = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
  public-subnet-cidr  = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
//  db-subnet-cidr      = ["10.0.192.0/21", "10.0.200.0/21", "10.0.208.0/21"]
  eks-cw-logging      = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  ec2-key             = "ci-stack"
}
