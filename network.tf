resource "aws_vpc" "smartfleet_vpc" {
  cidr_block           = "10.2.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(var.common_tags, { Name = "SmartFleet-VPC" })
}

resource "aws_subnet" "Public_subnet-a" {
  vpc_id                  = aws_vpc.smartfleet_vpc.id
  cidr_block              = "10.2.0.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${local.region}a"
  tags                    = merge(var.common_tags, { Name = "SmartFleet-public-subnet-01" })
}

resource "aws_subnet" "Private_subnet-a" {
  vpc_id                  = aws_vpc.smartfleet_vpc.id
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${local.region}a"
  tags                    = merge(var.common_tags, { Name = "SmartFleet-private-subnet-01" })
}

resource "aws_subnet" "Public_subnet-b" {
  vpc_id                  = aws_vpc.smartfleet_vpc.id
  cidr_block              = "10.2.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${local.region}b"
  tags                    = merge(var.common_tags, { Name = "SmartFleet-public-subnet-01" })
}

resource "aws_subnet" "Private_subnet-b" {
  vpc_id                  = aws_vpc.smartfleet_vpc.id
  cidr_block              = "10.2.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "${local.region}b"
  tags                    = merge(var.common_tags, { Name = "SmartFleet-public-subnet-01" })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.smartfleet_vpc.id
  tags   = merge(var.common_tags, { Name = "SmartFleet-igw" })
}

resource "aws_route_table" "to_net" {
  vpc_id = aws_vpc.smartfleet_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(var.common_tags, { Name = "SmartFleet_rtb_to_net" })
}

resource "aws_route_table_association" "associate-a" {
  subnet_id      = aws_subnet.Public_subnet-a.id
  route_table_id = aws_route_table.to_net.id
}

resource "aws_route_table_association" "associate-b" {
  subnet_id      = aws_subnet.Public_subnet-b.id
  route_table_id = aws_route_table.to_net.id
} 