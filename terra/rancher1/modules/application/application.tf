variable "vpc_id" {}

variable "subnet_id" {}

variable "name" {}

resource "aws_security_group" "rancher_sg" {
  name        = "${var.name}"
  description = "Allow HTTP traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "rancher" {
  ami                    = "ami-46e2c926"
  instance_type          = "t2.small"
  associate_public_ip_address = "true"
  key_name = "ivostoy"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.rancher_sg.id}"]

  tags {
    Name = "${var.name}"
  }
}

output "hostname" {
  value = "${aws_instance.rancher.private_dns}"
}

/*
variable "instance_id" {}
variable "public_ip" {}

data "aws_eip" "proxy_ip" {
  public_ip = "${var.public_ip}"
}

resource "aws_eip_association" "proxy_eip" {
  instance_id   = "${var.instance_id}"
  allocation_id = "${data.aws_eip.proxy_ip.id}"
}
*/
