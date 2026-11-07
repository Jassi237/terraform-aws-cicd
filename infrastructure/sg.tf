resource "aws_security_group" "allow_tls" {
  name        = "terraform-cicd-sg"
  description = "Allow HTTP and SSH connection"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "terraform-cicd-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each = {
    ssh  = 22
    http = 80
  }
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}