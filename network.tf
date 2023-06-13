resource "aws_vpc" "vpc-obli" {
  cidr_block = var.cidr-vpc
  tags = {
    Name = "vpc-obli"
  }
}

resource "aws_security_group" "sg-obli" {
  vpc_id = aws_vpc.vpc-obli.id
  ingress {
    from_port = var.ssh
    to_port = var.ssh
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_internet_gateway" "igw-obli" {
  vpc_id = aws_vpc.vpc-obli.id
  tags = {
    Name = "igw-obli"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.vpc-obli.id
  cidr_block = var.cidr-subnet-1
  availability_zone = "us-east-1a"
  tags {
    Name = subnet-obli-1
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.vpc-obli.id
  cidr_block = var.cidr-subnet-2
  availability_zone = "us-east-1b"
  tags {
    Name = subnet-obli-2
  }
}

resource "aws_route_table" "tabla-obli" {
  vpc_id = aws.vpc.vpc-obli.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-obli.id
  }
}

resource "aws_route_table_association" "asociacion-ruta" {
  subnet_id = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.tabla-obli.id
}