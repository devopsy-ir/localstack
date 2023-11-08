/* There are a number of ways to provide a value for the variable,
including passing it in at the command line (using the -var option), via
a file (using the -var-file option), or via an environment variable
(Terraform looks for environment variables of the name
TF_VAR_<variable_name>). */

/*
variable "object_example" {
	description = "An example of a structural type in Terraform"
	type = object({
		name = string
		age  = number
		tags = list(string)
		enabled = bool
	})
	default = { 
		name = "value1"
		age = 42
		tags = ["a", "b", "c"]
		enabled = true
	}
}

*/

output "public_ip" {
  value = aws_instance.example.public_ip
  description = "The public ip of web server"
}


# TF_VAR_server_port=8080

variable "server_port" {
	description = "The port of HTTP request"
	type = number
	# default = 8080
  
}

variable "cluster_name" {
	description = "The name of cluster phase"
	type = string
}

resource "aws_security_group" "instance" {
	name = "${var.cluster_name}-teraaform-example-instance"

	ingress {
		from_port = var.server_port
		to_port = var.server_port
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_instance" "example" {
	ami = "ami-ff0fea8310f3"
	instance_type = "t3.nano"
	vpc_security_group_ids = [ aws_security_group.instance.id ]

	user_data = <<-EOF
			#!/bin/bash
			echo "Hello, Islam" > index.html
			nohup busybox httpd -f -p ${var.server_port} &
			EOF

	tags = {
		Name = "${var.cluster_name}-Terraform-example"
	}
}
