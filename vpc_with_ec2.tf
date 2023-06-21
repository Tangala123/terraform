provider "aws" {
  region = var.location
}

## ## Create ec2 instance

resource "aws_instance" "demo-server" {
  ami                    = var.ami
  key_name               = var.key
  instance_type          = var.instance-type
  associate_public_ip_address = true
  subnet_id              = aws_subnet.demo-subnet.id
  vpc_security_group_ids = [aws_security_group.demo-sg.id]

  tags = {
    Name = "jhc-demo"
  }
}

## Create Vpc

resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "demo-vpc"
  }
}

## Create Subnet

resource "aws_subnet" "demo-subnet" {
  cidr_block = var.subnet-cidr
  vpc_id     = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-subnet"
  }
}

## Create internetgateway

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "demo-igw"
  }
}

## Create route_table

resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }

  tags = {
    Name = "demo-rt"
  }
}

## Create route_table_assosciation

resource "aws_route_table_association" "demo-rta" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

## Create security_group

resource "aws_security_group" "demo-sg" {
  name   = "demo-sg"
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "demo-sg"
  }
}