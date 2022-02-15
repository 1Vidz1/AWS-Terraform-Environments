//It's good practice to name the name file, main.tf
provider "aws" {
    region = "eu-west-1"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "terraform-bucket-101010"
}

//EC2 instances
resource "aws_instance" "web-bastion" {
  ami           = "ami-0bf84c42e04519c85"
  instance_type = var.instance_type
  subnet_id = aws_subnet.public-sub-1.id
  vpc_security_group_ids = [aws_security_group.allow_http_ssh.id]
  key_name = var.keypair
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex
  yum update -y
  yum install -y httpd.x86_64
  systemctl start httpd.service
  systemctl enable httpd.service
  echo “IF YOU CAN READ THIS, YOUR USER DATA IS CONFIGURED CORRECTLY” > /var/www/html/index.html
  EOF

  tags = {
      Name = "WebHost"
      env = var.enviroment
      owner = "avidigal"
  }
}

resource "aws_instance" "back-end-host" {
  ami           = "ami-0bf84c42e04519c85"
  instance_type = var.instance_type
  subnet_id = aws_subnet.private-sub-1.id 
  vpc_security_group_ids = [aws_security_group.back-end-sg.id]
  key_name = var.keypair
  associate_public_ip_address = false

  tags = {
      Name = "Back-End"
      env = var.enviroment
      owner = "avidigal"
  }
}

