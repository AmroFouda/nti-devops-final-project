
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = "nti-db-password"
}

resource "aws_db_instance" "nti_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "ntiDB"
  username             = "admin"
  password             = data.aws_secretsmanager_secret_version.db_password.secret_string
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}