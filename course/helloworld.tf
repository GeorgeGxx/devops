provider "aws" {
    region = "us-east-2"
    profile = "user1"
}

//this is a string variable

variable "firststring" {
    type = string
    default = "this is my first string"
}

variable "multilinestring" {
    type = string
    default = <<EOH
    this is a multiline
    string
    newline
    EOH
}

output "myfirstoutput" {
    value = "${var.firststring}"
}

output "mymultilineoutput" {
    value = "${var.multilinestring}"
}