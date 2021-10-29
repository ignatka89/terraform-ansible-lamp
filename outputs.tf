output "dburl" {
  value = aws_db_instance.database.address
}

output "alburl" {
  value = aws_lb.lampalb.dns_name
}
