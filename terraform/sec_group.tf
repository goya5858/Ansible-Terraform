# SSHのセキュリティグループ
resource "aws_security_group" "ssh" {
  name   = "ssh_sg"
  vpc_id = aws_vpc.ansible_vpc.id
}

resource "aws_security_group_rule" "ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] # 接続元を限定する場合は変更する
  security_group_id = aws_security_group.ssh.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh.id
}

# セキュリティグループの追加方法
# たとえば、httpのセキュリティグループが必要な場合は以下のように追加する
resource "aws_security_group" "http" {
  name   = "http_sg"
  vpc_id = aws_vpc.ansible_vpc.id
}

resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.http.id
}

resource "aws_security_group_rule" "http_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.http.id
}