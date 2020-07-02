resource "aws_vpc" "this" {
  cidr_block = var.cidr_block

  tags = {
    Name   = var.client_name
    Client = var.client_name
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  count = 3

  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  vpc_id                  = aws_vpc.this.id
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name   = "${var.client_name}-public-${data.aws_availability_zones.available.names[count.index]}"
    Client = var.client_name
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Client = var.client_name
  }
}

resource "aws_route" "this" {
  route_table_id         = aws_vpc.this.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
