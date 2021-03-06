#################
#### VPC
#################

resource "aws_vpc" "my-main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = false
  enable_dns_support   = true
  instance_tenancy     = "default"
  
  tags = {
    Site = "my-web-site-edvarga"
    Name = "my-vpc-edvarga"
  }
}


data "aws_availability_zones" "available" {}


######################
#### PUBLIC SUBNETS
######################

resource "aws_subnet" "my-public1" {
  vpc_id                  = aws_vpc.my-main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "my-public1-edvarga"
    Site = "my-web-site"
  }
}

resource "aws_subnet" "my-public2" {
  vpc_id                  = aws_vpc.my-main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "my-public2-edvarga"
    Site = "my-web-site"
  }
}

######################
#### PRIVATE SUBNETS
######################

resource "aws_subnet" "my-private1" {
  vpc_id                  = aws_vpc.my-main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "my-private1-edvarga"
    Site = "my-web-site"
  }
}

resource "aws_subnet" "my-private2" {
  vpc_id                  = aws_vpc.my-main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "my-private2-edvarga"
    Site = "my-web-site"
  }
}

#################
#### IGW
#################

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-main.id  

  tags = {
    Name = "my-igw-edvarga"
    Site = "my-web-site"
  }
}

#################
#### RT
#################

resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.my-main.id  

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }  

  tags = {
    Site = "my-web-site"
    Name = "my-rt-edvarga"
  }
}

#######################
#### RT ASSOCIATION
#######################

resource "aws_route_table_association" "my-public1" {
  subnet_id      = aws_subnet.my-public1.id
  route_table_id = aws_route_table.my-rt.id
}

resource "aws_route_table_association" "my-public2" {
  subnet_id      = aws_subnet.my-public2.id
  route_table_id = aws_route_table.my-rt.id
}
