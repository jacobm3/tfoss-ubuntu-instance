resource "aws_security_group" "jacobm-ubuntu" {
  name = "jacobm-ubuntu-sg"
  vpc_id      = "vpc-972d08ec"

  tags {
    Name    = "jacobm-ubuntu-sg"
    TTL = "99999"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

}
