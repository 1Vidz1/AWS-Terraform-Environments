vpc = "10.10.0.0/16"
pub1 = "10.10.0.0/18"
pub2 = "10.10.128.0/18"
priv1 = "10.10.64.0/18"
enviroment = "Test Enviroment"
instance_type = "t2.micro"

//To create key: aws ec2 create-key-pair --key-name KeyName --query 'KeyMaterial' --output text > ~/.ssh/KeyName.pem
keypair = "TheKey"