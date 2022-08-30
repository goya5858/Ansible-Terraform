resource "aws_vpc" "ansible_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "name" = "ansible-sample"
  }
}

resource "aws_subnet" "public-1a" {
  vpc_id = aws_vpc.ansible_vpc.id
  availability_zone = "ap-northeast-1a"
  cidr_block = "10.0.0.0/24"
  tags = {
    "name" = "ansible-sample"
  }
}

resource "aws_internet_gateway" "ansible-IGW" {
  vpc_id = aws_vpc.ansible_vpc.id
  tags = {
    "name" = "ansible-sample"
  }
}

resource "aws_route_table" "ansible-route-table" {
  vpc_id = aws_vpc.ansible_vpc.id
  tags = {
    "name" = "ansible-sample"
  }
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id = aws_route_table.ansible-route-table.id
  gateway_id = aws_internet_gateway.ansible-IGW.id
}

resource "aws_route_table_association" "ansible-subnet-binding" {
  subnet_id = aws_subnet.public-1a.id
  route_table_id = aws_route_table.ansible-route-table.id
}