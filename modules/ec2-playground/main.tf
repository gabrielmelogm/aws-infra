resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
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
    Name = "allow_ssh"
  }
}

resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.key_pair.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  subnet_id     = aws_subnet.public_subnet.id
  associate_public_ip_address = true

  tags = {
    Name = "playground"
  }

  root_block_device {
    volume_size = 40
    volume_type = "gp3"
    delete_on_termination = true
  }
}

resource "aws_route53_zone" "route_zone" {
  name = var.domain
}

resource "aws_route53_record" "route_record" {
  zone_id = aws_route53_zone.route_zone.id
  name = var.sub_domain
  type = "A"
  ttl = 60
  records = [aws_instance.ec2_instance.public_ip]
}

output "public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "public_dns" {
  value = aws_instance.ec2_instance.public_dns
}
