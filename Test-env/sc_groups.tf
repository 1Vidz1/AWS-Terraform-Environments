resource "aws_security_group" "front_access" {
  name        = "front_access"
  description = "Protocols for outside access"
  vpc_id = aws_vpc.env-vpc.id 

  tags = {
    Name = "front-access"
  }
}
resource "aws_security_group_rule" "pub1-http" {
  type              = "ingress"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front_access.id
}
resource "aws_security_group_rule" "pub1-ssh" {
  type              = "ingress"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front_access.id
}
resource "aws_security_group_rule" "postgre" {
  type              = "ingress"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front_access.id
}
resource "aws_security_group_rule" "outbound" {
  type              = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    security_group_id = aws_security_group.front_access.id
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
resource "aws_security_group_rule" "priv1-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.back-end-sg.id
}


