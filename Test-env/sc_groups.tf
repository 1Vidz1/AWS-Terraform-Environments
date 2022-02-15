resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id = aws_vpc.env-vpc.id 

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Enable VPC"  
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}

resource "aws_security_group" "back-end-sg" {
  name        = "back-end-sg"
  description = "This sg is for the back-end machines"
  vpc_id = aws_vpc.env-vpc.id

  tags = {
    Name = "back-end-sg"
  }
}

resource "aws_security_group_rule" "ssh_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.back-end-sg.id
}
