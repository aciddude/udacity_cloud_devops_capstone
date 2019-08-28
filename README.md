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
  - edit this variable AWS_PROFILE=TheProfileFrom ~/.aws/credentials
  - edit this variable TF_VAR_aws_access_key=YOURACCESSKEY
  - edit this variable TF_VAR_aws_secret_key=YOURSECRETKEY
- Save the script

- Edit dev.tfvars and fill it out with your own information


### 1 - Terraform Init
You can execute the `run.sh` script with `init`

This is to initialise the project directory for Terraform

```
./run init

```
Sample Output:

```
---
Initializing modules...

Initializing the backend...

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.24"
* provider.http: version = "~> 1.1"
* provider.local: version = "~> 1.3"
* provider.null: version = "~> 2.1"
* provider.random: version = "~> 2.2"
* provider.template: version = "~> 2.1"

Terraform has been successfully initialized!
```





### 2 - Terraform plan
You can execute the `run.sh` script with `plan`

This will show you your terraform plan, this plan will be executed and infrastructure in AWS will be created.

```
./run plan

```

Sample Output:

```
---
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

module.eks-cluster.module.eks.data.http.workstation-external-ip: Refreshing state...
data.template_file.user-data: Refreshing state...
data.aws_availability_zones.available: Refreshing state...
data.aws_ami.amazon-linux: Refreshing state...
data.aws_route53_zone.pools-ac: Refreshing state...
module.eks-cluster.module.eks.data.aws_ami.bastion: Refreshing state...
module.eks-cluster.module.eks.data.aws_ami.eks-worker-ami: Refreshing state...

------------------------------------------------------------------------
...... REDACTED
...... REDACTED
...... REDACTED
...... REDACTED
...... REDACTED


Plan: 83 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```


### 3 - Apply
You can execute the `run.sh` script with `apply`

This will apply your terraform plan and actually starts the creation of the infrastructure.

The `apply` command for this script also deploys resources for kubernetes, look at the `run.sh` script for more information

```
./run apply

```

Sample Output:

```
---
module.eks-cluster.module.eks.data.http.workstation-external-ip: Refreshing state...
data.template_file.user-data: Refreshing state...
data.aws_availability_zones.available: Refreshing state...
data.aws_route53_zone.pools-ac: Refreshing state...
data.aws_ami.amazon-linux: Refreshing state...
module.eks-cluster.module.eks.data.aws_ami.bastion: Refreshing state...
module.eks-cluster.module.eks.data.aws_ami.eks-worker-ami: Refreshing state...
module.eks-cluster.module.eks.aws_iam_policy.external-dns-policy: Creating...
module.eks-cluster.module.eks.aws_iam_role.cluster: Creating...
module.eks-cluster.module.eks.module.vpc.aws_vpc.this[0]: Creating...
module.eks-cluster.module.eks.aws_iam_role.node: Creating...
module.eks-cluster.module.eks.module.vpc.aws_eip.nat[2]: Creating...
module.eks-cluster.module.eks.module.vpc.aws_eip.nat[0]: Creating...
module.eks-cluster.module.eks.module.vpc.aws_eip.nat[1]: Creating...

```



### 4 - Destroy
You can execute the `run.sh` script with `destroy`

This will delete all the created kubernetes resources and then delete the AWS infrastructure.

```
./run destroy

```

### _Notes & Things to Remember Part 2_:
The kubernetes deployment creates an ALB in aws, sometimes this prevents terraform from destroying the infrastructure. You can get around this by Deleting the ALB and Target Group via the AWS console and then running `./run.sh destroy`
