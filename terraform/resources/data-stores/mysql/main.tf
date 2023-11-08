resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine = "mysql"
    instance_class = "db.t3.nano"
    skip_final_snapshot = true
    db_name = "example_database"
    allocated_storage = 10

    username = var.db_username
    password = var.db_password

}
