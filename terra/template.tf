provider "aws" {
  region = "us-east-1"
}

module "app1" { 
  source = "./modules/application" 
   vpc_id = "${aws_vpc.my_vpc.id}" 
  	subnet_id = "${aws_subnet.public.id}" 
  	name = "myapp1" 
} 