
#Create A VPC 

resource "aws_vpc" "myvpc" {
  cidr_block = "172.16.0.0/16"

  #By Specifying tag like this, Vpc gets the name specified    
  tags = {
    Name = "roshan-tfvnet"
  }
}

#Public Subnet 1

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "172.16.1.0/24"
  availability_zone= "us-east-2a"

  tags = {
    Name = "Public1"
  }

   depends_on = [aws_vpc.myvpc]
}

#Public Subnet 2 

resource "aws_subnet" "public2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "172.16.2.0/24"
  availability_zone= "us-east-2b"

  tags = {
    Name = "Public2"
  }
  depends_on = [aws_vpc.myvpc]
}

#Private Subnet 1 

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "172.16.3.0/24"
  availability_zone= "us-east-2a"

  tags = {
    Name = "Private1"
  }

  depends_on = [aws_vpc.myvpc]
}

#Private Subnet 2
resource "aws_subnet" "private2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "172.16.4.0/24"
  availability_zone= "us-east-2b"

  tags = {
    Name = "Private2"
  }

  depends_on = [aws_vpc.myvpc]
}


#Create an Internet Gateway 

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "main"
  }
}

#Elastic IP 
resource "aws_eip" "ngweip" {
    vpc      = true
}


#Create a NAT Gateway 

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ngweip.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #Depends on both IGW and NGW 
  depends_on = [aws_internet_gateway.gw,aws_eip.ngweip]
}


