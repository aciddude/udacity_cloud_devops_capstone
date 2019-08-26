
output "eks-kubeconfig" {
  value = module.eks-cluster.kubeconfig
}

output "eks-config-map" {
  value = module.eks-cluster.config-map
}
