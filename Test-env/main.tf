//It's good practice to name the name file, main.tf

//S3 Buckets
/* resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "terraform-bucket-101010"
} */

//EC2 instances
resource "aws_instance" "web-bastion" {
  ami           = "ami-0bf84c42e04519c85"
  instance_type = var.instance_type
  subnet_id = aws_subnet.public-sub-1.id
  vpc_security_group_ids = [aws_security_group.front_access.id]
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

//RDS
resource "aws_db_instance" "test-db" {
  allocated_storage    = 5
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  db_name              = "mydb"
  username             = "avidigal"
  password             = "pass12345678"
  publicly_accessible  = true
  parameter_group_name = aws_db_parameter_group.db_test_group.name 
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.data-sub-1.id 
  vpc_security_group_ids = [aws_security_group.front_access.id]
}
resource "aws_db_parameter_group" "db_test_group" {  
  name   = "dbgroup"  
  family = "postgres13"
  parameter {    
    name  = "log_connections"    
    value = "1"  
  }
} 

