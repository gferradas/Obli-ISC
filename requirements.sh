#!/bin/bash

path="$HOME/Obli-ISC/src"

iterar_carpetas() {
    local ruta=$1

    for carpeta in "$ruta"/*; do
        actual=$(basename "$carpeta")
        nombre=$(basename "$ruta")

        if [[ -d $carpeta ]]; then
            iterar_carpetas "$ruta/$actual"
        elif [[ -f "$ruta/Dockerfile" ]]; then
            docker build -t gferradas/$nombre:v2 "$ruta/"
            echo "Creado Docker image de $ruta/Dockerfile"
            docker push gferradas/$nombre:v2
            echo "Pusheado gferradas/$nombre:v2"
        fi
    done
}

iterar_carpetas $path

export TF_VAR_arn_role=$(aws iam get-role --role-name LabRole --query 'Role.Arn' --output text)
