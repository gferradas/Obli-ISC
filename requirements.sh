#!/bin/bash
#seccion de comprobacion si tiene aws cli en el cliente sino se instala
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

echo " "

echo "Actualice las credenciales de aws"

sleep 1
#se abri vi para que se modifquen las credenciales de la cli
vi $HOME/.aws/credentials

#Se busca en la carpeta src y se itera los archivos en busca de los docker file donde se construyen con el tag v2 y pushean hacia dockerhub
find $HOME/Obli-ISC/src -maxdepth 2 -type d -exec sh -c 'cd "{}" && docker build -t "gferradas/$(basename {}):v2" . && docker push "gferradas/$(basename {}):v2"' \;