provider "aws" {
  region = "us-east-2"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "10.0.1.0/24"
}

module "crazy_foods" {
  source    = "./modules/application"
  vpc_id    = "${aws_vpc.my_vpc.id}"
  subnet_id = "${aws_subnet.public.id}"
  name      = "CrazyFoods ${module.mighty_trousers.hostname}"
}

module "mighty_trousers" {
  source    = "./modules/application"
  vpc_id    = "${aws_vpc.my_vpc.id}"
  subnet_id = "${aws_subnet.public.id}"
  name      = "MightyTrousers"
}
