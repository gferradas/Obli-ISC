#!/bin/bash
if command -v aws &> /dev/null
then
    echo "cumple requerimientos"
else
    cd "$HOME"
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install -i /usr/local/aws-cli -b /usr/local/bin
    aws configure
fi

echo "#####################################################################################"

echo "Actualice las credenciales de aws"
sleep 1
vim $HOME/.aws/credentials


export TF_VAR_arn_role=$(aws iam get-role --role-name LabRole --query 'Role.Arn' --output text)

find $HOME/Obli-ISC/src -type d -exec sh -c 'cd "{}" && docker build -t "gferradas/$(basename {}):v2" . && docker push "gferradas/$(basename {}):v2"' \;

