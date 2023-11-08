module "ec2" {
	source = "../../modules/ec2"

	cluster_name = "stage"
	server_port = 8080
}
