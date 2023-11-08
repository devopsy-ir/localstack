module "ec2" {
	source = "../../modules/ec2"

	cluster_name = "prod"
	server_port = 8080
}
