provider "aws" {
  version = "~> 0.1"
  region = "us-west-1"
}

resource "aws_vpc" "rancher_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.rancher_vpc.id}"
  cidr_block = "10.0.1.0/24"
}

module "rancher" {
  name      = "rancher"
  source    = "./modules/application"
  vpc_id    = "${aws_vpc.rancher_vpc.id}"
  subnet_id = "${aws_subnet.public.id}"
}

