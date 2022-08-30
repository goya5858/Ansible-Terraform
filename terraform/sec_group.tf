resource "aws_security_group" "example_ec2" {
  name = "example-ec2"
  description = "ansible-sec-group"
  vpc_id = aws_vpc.ansible_vpc.id

  ingress {
    cidr_blocks = [ aws_vpc.ansible_vpc.cidr_block ]
    description = "value"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  } 

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "value"
    from_port = 0
    ipv6_cidr_blocks = [ "::/0" ]
    protocol = "-1"
    to_port = 0
  } 
}