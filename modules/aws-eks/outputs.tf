output "kubeconfig" {
  value       = module.eks.kubeconfig
  description = "EKS Kubeconfig"
}

output "config-map" {
  value       = module.eks.config-map-aws-auth
  description = "K8S config map to authorize"
}

output "vpc_id" {
  value       = module.eks.vpc_id
  description = "VPCID"
}

output "public_subnets" {
  value       = module.eks.public_subnets
  description = "public_subnets"
}


output "private_subnets" {
  value       = module.eks.private_subnets
  description = "public_subnets"
}
