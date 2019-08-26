output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPCID"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "public_subnets"
}


output "private_subnets" {
  value       = module.vpc.private_subnets
  description = "public_subnets"
}
