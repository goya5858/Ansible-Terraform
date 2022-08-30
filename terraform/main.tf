resource "aws_instance" "default" {
  ami = "ami-07200fa04af91f087"
  instance_type = "t2.micro"
  tags = {
    "Name" = "terraform-ansible"
  }
  subnet_id = aws_subnet.public-1a.id
  vpc_security_group_ids = [aws_security_group.example_ec2.id]
}