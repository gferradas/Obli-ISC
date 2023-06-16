#!/bin/bash

#se va a la carpeta terraform donde se realiza el init y el apply el usuario debe de igual forma dar el yes

cd $HOME/Obli-ISC/Terraform
terraform init
terraform apply --var-file=variables.tfvars
#se extrae el nombre del cluster y se alamacena en variable output para luego configurar el kubectl con la variable
output=$(terraform output -state=/root/Obli-ISC/Terraform/terraform.tfstate | cut -d "=" -f 2 | tr -d '"')
aws eks update-kubeconfig --region us-east-1 --name $output

#se itera dentro de la carpeta manifests y se realizan los deployments
for file in "$HOME/Obli-ISC/manifests/"; do
    kubectl apply -f $file
done

#se extrae la url del loadbalancer que es quien muestra la pagina de la tienda y se almacena en variable para luego mostrarla
url=$(kubectl get svc | cut -d " " -f 15 | grep "elb")

echo "la url para la pagina es: "
#se muestra la url del elb
echo "$url"
