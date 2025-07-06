
resource "aws_security_group" "C-VPC-Web-sg" {
    vpc_id = var.vpc_id
    name = "Custom-VPC-Web-sg"
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
}

resource "aws_security_group_rule" "allow_http_from_lb_to_web" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.C-VPC-Web-sg.id  # Target SG
  source_security_group_id = aws_security_group.C-VPC-ALB-sg.id # Source SG
}


resource "aws_security_group" "C-VPC-app-sg" {
    name = "Custom-vpc-app-sg"
    vpc_id = var.vpc_id
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
  }
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
  }
}

resource "aws_security_group_rule" "allow_http_from_web_to_app" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.C-VPC-app-sg.id
  source_security_group_id = aws_security_group.C-VPC-Web-sg.id
}


resource "aws_security_group" "C-VPC-db-sg" {
    name = "Custom-vpc-db-sg"
    vpc_id = var.vpc_id
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
  }
}

resource "aws_security_group_rule" "allow_mysql_from_app_to_rds" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.C-VPC-db-sg.id
  source_security_group_id = aws_security_group.C-VPC-app-sg.id
}


resource "aws_security_group" "C-VPC-ALB-sg" {
    vpc_id = var.vpc_id
    name = "Custom-VPC-ALB-sg"
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "C-VPC-Bastion-sg" {
    vpc_id = var.vpc_id
    name = "Custom-VPC-Bastion-sg"
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}