output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}
output "websubnet_id" {
  value = aws_subnet.websubnet.id
}
output "appsubnet_id" {
  value = aws_subnet.appsubnet.id
}
output "dbsubnet_id" {
  value = aws_subnet.dbsubnet.id
}
output "dbsubnet_group" {
  value = aws_db_subnet_group.default.name
}
output "ALB_id" {
  value = aws_lb.internet_lb.id
}
output "internet_tg_arn" {
  value = aws_lb_target_group.Internet_TarGrp.arn
}
