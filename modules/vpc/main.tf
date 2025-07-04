resource "aws_vpc" "custom_vpc" {
  cidr_block = var.cidr_block
  tags = {
    Name = "custom vpc"
  }
}
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "myigw"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.websubnet.id

  tags = {
    Name = "nat-gateway"
  }
}

#WebSubnet
resource "aws_subnet" "websubnet" {
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.web-cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "web-subnet"
  }
}
#AppSubnet
resource "aws_subnet" "appsubnet" {
  availability_zone = "us-east-1b"
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.app-cidr_block
  tags = {
    Name = "app-subnet"
  }
}
#DBSubnet
resource "aws_subnet" "dbsubnet" {
  availability_zone = "us-east-1c"
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.db-cidr_block
  tags = {
    Name = "DB-subnet"
  }
}

#ALB_Subnet_1
resource "aws_subnet" "albsubnet" {
  availability_zone = "us-east-1a"
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.alb-cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "public-albsubnet"
  }
}

#ALB_Subnet_2
resource "aws_subnet" "albsubnet2" {
  availability_zone = "us-east-1b"
  vpc_id = aws_vpc.custom_vpc.id
  cidr_block = var.alb2-cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}


#PublicRouteTable
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }

  tags = {
    Name = "Cus_vpc-Pub_rt"
  }
}

#PrivateRouteTable
resource "aws_route_table" "private-rt" {
vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
 tags = {
    Name ="Cus_vpc-Pvt_rt"
 }
}

#websubnet association
resource "aws_route_table_association" "web-pub-rt" {
  subnet_id      = aws_subnet.websubnet.id
  route_table_id = aws_route_table.public-rt.id
}

#appsubnet association
resource "aws_route_table_association" "app-pvt-rt" {
  subnet_id      = aws_subnet.appsubnet.id
  route_table_id = aws_route_table.private-rt.id
}

#dbsubnet association
resource "aws_route_table_association" "db-pvt-rt" {
  subnet_id      = aws_subnet.dbsubnet.id
  route_table_id = aws_route_table.private-rt.id
}

#DB_Subnet_group
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [aws_subnet.dbsubnet.id, aws_subnet.appsubnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

#Application_LoadBalancer
resource "aws_lb" "internet_lb" {
  name               = "internet-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = [aws_subnet.albsubnet.id,aws_subnet.albsubnet2.id]
}

resource "aws_lb_target_group" "Internet_TarGrp" {
  name     = "internet-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.custom_vpc.id
}



