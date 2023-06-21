variable "location" {
 default = "us-east-1"
}

variable "ami" {
 default = "ami-022e1a32d3f742bd8"
}

variable "key" {
 default = "guru"
}

variable "instance-type" {
 default = "t2.micro"
}

variable "vpc-cidr" {
 default = "10.0.0.0/16"
}

variable "subnet-cidr" {
 default = "10.0.0.0/24"
}

