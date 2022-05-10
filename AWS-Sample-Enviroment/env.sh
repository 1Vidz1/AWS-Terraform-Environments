#!/bin/ksh

terraform -v
echo "Initializing terraform...."

read TF_VAR_region?"Region: "

echo "Terraform plan...."
terraform plan -out=tfplan -input=false -var "region=$TF_VAR_region"