#Web Server security Group 
resource "aws_security_group" "websg" {
  name        = "websg"
  description = "Allow SSH and Web Traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }


 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

   ingress {
    description      = "TLS from VPC"
    from_port        = 23
    to_port          = 23
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "websg"
  }

    depends_on = [aws_vpc.myvpc]

}

#DB server security Group 
resource "aws_security_group" "dbsg" {
  name        = "dbsg"
  description = "Allow SSH and MySQL Traffic"
  vpc_id      = aws_vpc.myvpc.id

  
 ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.myvpc.cidr_block]
   
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "dbsg"
  }

  depends_on = [aws_vpc.myvpc]
}


