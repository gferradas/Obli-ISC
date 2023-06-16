#!/bin/bash
export TF_VAR_arn_role=$(aws iam get-role --role-name LabRole --query 'Role.Arn' --output text)

find $HOME/Obli-ISC/src -type d -exec sh -c 'cd "{}" && docker build -t "gferradas/$(basename {}):v2" . && docker push "gferradas/$(basename {}):v2"' \;

