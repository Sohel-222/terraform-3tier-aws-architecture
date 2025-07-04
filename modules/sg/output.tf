output "web_sg_id" {
  value = aws_security_group.C-VPC-Web-sg.id
}
output "app_sg_id" {
  value = aws_security_group.C-VPC-app-sg.id
}
output "db_sg_id" {
  value = aws_security_group.C-VPC-db-sg.id
}
output "alb_sg_id" {
  value = aws_security_group.C-VPC-ALB-sg.id
}