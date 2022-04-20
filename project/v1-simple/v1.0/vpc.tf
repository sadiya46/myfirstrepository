resource "aws_vpc" "she-eks-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"


  tags = {
    Name = "she-eks-vpc"
  }
}

resource "aws_subnet" "dev-subpub01" {
  vpc_id                  = aws_vpc.she-eks-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-east-1a"
  tags = {
    Name = "dev-subpub01"
  }
}

resource "aws_subnet" "dev-subpvt01" {
  vpc_id            = aws_vpc.she-eks-vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "dev-subpvt01"
  }
}


resource "aws_nat_gateway" "she-nat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.dev-subpvt01.id
}




// enable_nat_gateway   = "true"
// single_nat_gateway   = "true"

