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
    cidr_blocks = [ var.cidr-global ]
  }
  egress {
    from_port = "0"
    to_port = "0"
    protocol = "-1"
    cidr_blocks = [ var.cidr-global ]
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
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-obli-1"
  }
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.vpc-obli.id
  cidr_block = var.cidr-subnet-2
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-obli-2"
  }
}

resource "aws_route_table" "tabla-obli" {
  vpc_id = aws_vpc.vpc-obli.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-obli.id
  }
}

resource "aws_nat_gateway" "nat-obli" {
  connectivity_type = "public"
  subnet_id = aws_subnet.subnet-1.id
  allocation_id = aws_eip.eip-obli.id
  tags ={
    Name = "Nat-Obli"
  }
  depends_on = [ aws_internet_gateway.igw-obli ]
}

resource "aws_route_table" "nat-table" {
  vpc_id = aws_vpc.vpc-obli.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-obli.id
  }
}

resource "aws_route_table_association" "nat-associate" {
  subnet_id = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.nat-table.id
}

resource "aws_route_table_association" "asociacion-ruta" {
  subnet_id = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.tabla-obli.id
}

resource "aws_eip" "eip-obli" {
  domain = "vpc"
}