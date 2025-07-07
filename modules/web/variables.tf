variable "ami_id" {
  
}
variable "instance_type" {

}
variable "subnet_id" {
  
}
variable "vpc_sg_id" {
  
}
variable "target_group_arn" {
  description = "ARN of the ALB Target Group"
  type        = string
}
variable "key_name" {
  type = string
}
