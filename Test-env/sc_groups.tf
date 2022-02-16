resource "aws_security_group" "front_access" {
  name        = "front_access"
  description = "Protocols for outside access"
  vpc_id = aws_vpc.env-vpc.id 

  tags = {
    Name = "front-access"
  }
}
resource "aws_security_group_rule" "http" {
  type              = "ingress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front-access.id
}
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front-access.id
}

///////////////////

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


