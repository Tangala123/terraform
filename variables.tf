variable "location" {
 default = "us-east-1"
}

variable "ami" {
 default = "ami-06b09bfacae1453cb"
}

variable "key" {
 default = "prasanna"
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

