variable "db_username" {
    description = "MYSQL username"
    type = string
    sensitive = true
  }

  variable "db_password" {
    description = "MYSQL password"
    type = string
    sensitive = true
    
  }