# Udacity Cloud Devops - Capstone

This project contains Terraform code that creates the following in AWS:

- Standard AWS Infra (VPC, IGW, NAT-GW..etc)
- Jenkins Master server EC2 instance
- Bastion Server EC2 instance
- EKS Cluster

further to creating to the infrastructure in AWS the script applies the following Kubernetes resources to the EKS cluster:

- ALB ingress controller & RBAC roles needed
- External DNS  & RBAC roles needed
- Sample WebApp: Deployment, Ingress, Service, Namespace

### _Notes & Things to Remember_:
- The Sample WebApp deployment image is set to `:latest`
- You may need to edit some of the code and/or variables in order for it to work for your environment
- If run successfully you should be able to visit weather.YOURDOMAIN.TLD and see the sample nodeJS app

### **Important!** - Please read **all** the steps below carefully


### 0 - Getting Started

Clone the project
```
git clone https://github.com/aciddude/udacity_cloud_devops_capstone.git
```

- Edit the `run.sh` script
  - edit this variable TF_VAR_aws_access_key=YOURACCESSKEY
  - edit this variable TF_VAR_aws_secret_key=YOURSECRETKEY
- Save the script
