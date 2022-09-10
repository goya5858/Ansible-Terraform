# 最新のAmazonLinux2のイメージ
#data "aws_ami" "latest_amzn2" {
#  owners      = ["679593333241"]
#  most_recent = true
#  filter {
#    name   = "name"
#    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
#  }
#
#  filter {
#    name   = "virtualization-type"
#    values = ["hvm"]
#  }
#}

# キーペア
# 変数で指定した値を設定
resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = file("${var.key_name}.pub")
}

# インスタンス
resource "aws_instance" "this" {
  instance_type = "t3.micro" # インスタンスタイプは任意に設定する
  vpc_security_group_ids = [aws_security_group.ssh.id, aws_security_group.http.id]

  # EBSのサイズとタイプを指定する場合は以下のように追加する
  # root_block_device {
  #   volume_size = 30 # 単位GB
  #   volume_type = "gp3" # gp2がデフォルト。 他はstandard, gp3, io1, io2, sc1, st1。
  # }

  #ami = data.aws_ami.latest_amzn2.id
  ami = "ami-07200fa04af91f087"

  subnet_id = aws_subnet.public-1a.id
  private_ip = var.private_ip
  associate_public_ip_address = "true"

  key_name = aws_key_pair.this.key_name

  tags = {
    Name = var.resource_name # インスタンス名
  }

  #provisioner "remote-exec" {
  #  connection {
  #    type = "ssh"
  #    user = "ubuntu"
  #    host = var.private_ip
  #    private_key = file("${var.key_name}")
  #  }
  #  inline = [
  #    "sudo apt install -y python"
  #  ]
  #}

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${self.public_ip}, --private-key ${var.key_name} playbook.yml"
  }
}

# EIPを使う場合は以下を追加する
#resource "aws_eip" "this" {
#  instance = aws_instance.this.id
#  vpc      = true
#}
