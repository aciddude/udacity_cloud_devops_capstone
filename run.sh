#!/bin/bash

export AWS_PROFILE=personal
export TF_VAR_aws_access_key=
export TF_VAR_aws_secret_key=


echo "Building stack"
echo "Run with  plan/apply/destroy/init as a switch"
echo  "---"

if [ $1 == "init" ]
  then
      terraform init ./stack/
      pwd
fi

if [ $1 == "plan" ]
  then
      terraform plan  -var-file=./stack/dev.tfvars ./stack/
      pwd
fi


if [ $1 == "apply" ]
  then
      export AWS_PROFILE=personal
      terraform apply -var-file=./stack/dev.tfvars  -auto-approve ./stack/

      echo "Applying KubeCTL config"
      terraform output eks-kubeconfig > ${HOME}/.kube/config

      echo "Applying AWS auth configMap"
      terraform output eks-config-map > ./config-map-aws-auth.yml
      kubectl apply -f ./config-map-aws-auth.yml

      echo "going to sleep for 60s because AWS lies a lot."
      sleep 60
      echo "Getting Kube Nodes"
      kubectl get nodes

      echo "Applying ALB Ingress controller"
      kubectl apply -f ./stack/k8s-templates/rbac-role.yml
      kubectl apply -f ./stack/k8s-templates/alb-ingress-controller.yml
      kubectl apply -f ./stack/k8s-templates/external-dns.yml

      echo "Deploying WebApp"
      kubectl apply -f ./stack/k8s-templates/webapp/webapp-namespace.yml
      kubectl apply -f ./stack/k8s-templates/webapp/webapp-service.yml
      kubectl apply -f ./stack/k8s-templates/webapp/webapp-ingress.yml
      kubectl apply -f ./stack/k8s-templates/webapp/webapp-deployment.yml
      pwd
fi


if [ $1 == "destroy" ]
  then

      echo "DELETING!!! ALB Ingress controller"
      kubectl delete -f ./stack/k8s-templates/rbac-role.yml
      kubectl delete -f ./stack/k8s-templates/alb-ingress-controller.yml
      kubectl delete -f ./stack/k8s-templates/external-dns.yml

      echo "DELETING!!!!  WebApp"
      kubectl delete -f ./stack/k8s-templates/webapp/webapp-service.yml
      kubectl delete -f ./stack/k8s-templates/webapp/webapp-ingress.yml
      kubectl delete -f ./stack/k8s-templates/webapp/webapp-deployment.yml
      kubectl delete -f ./stack/k8s-templates/webapp/webapp-namespace.yml

      echo "DESTROYING INFRASTRUCTURE!!"
      terraform destroy -var-file=./stack/dev.tfvars  -auto-approve ./stack/
      pwd
fi
