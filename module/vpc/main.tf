resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

resource "aws_subnet" "public" {
  count = length(var.subnet_public_availability_zone)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = count.index == 0 ? var.subnet_public_cidr : cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone       = var.subnet_public_availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.public_subnet_name}-${count.index + 1}"
    Type = "Public"
  })
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.private_subnet_availability_zone[count.index]

  tags = merge(var.tags, {
    Name = "${var.private_subnet_name}-${count.index + 1}"
    Type = "Private"
  })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = var.internet_gateway
  })
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"

  tags = merge(var.tags, {
    Name = var.nat_ip
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(var.tags, {
    Name = var.nat_gateway
  })

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = var.public_route_table
    Type = "Public"
  })
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(var.tags, {
    Name = var.private_route_table
    Type = "Private"
  })
}

resource "aws_route_table_association" "public" {
  count = length(var.subnet_public_availability_zone)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
