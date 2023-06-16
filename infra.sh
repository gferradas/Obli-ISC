#!/bin/bash

cd $HOME/Obli-ISC/Terraform
terraform init
terraform apply --var-file=variables.tfvars
output=$(terraform output -state=/root/Obli-ISC/Terraform/terraform.tfstate | cut -d "=" -f 2 | tr -d '"')
aws eks update-kubeconfig --region us-east-1 --name $output

for file in "$HOME/Obli-ISC/manifests/"; do
    kubectl apply -f $file
done

url=$(kubectl get svc | cut -d " " -f 15 | grep "elb")

echo "la url para la pagina es: "

echo "$url"
