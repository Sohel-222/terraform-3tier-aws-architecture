#Web_server_instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.vpc_sg_id]
  key_name = var.key_name
  tags = {
    Name = "Web_Server"
  }
  provisioner "local-exec" {
  command = <<EOT
    echo [webserver] >> ${path.root}/ansible/hosts.ini && \
    echo ${self.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=../NayaWala ansible_ssh_common_args="'-o StrictHostKeyChecking=no'" >> ${path.root}/ansible/hosts.ini
  EOT
  }
}

resource "aws_lb_target_group_attachment" "web_instance_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.web_server.id
  port             = 80
}

output "web_instance_id" {
  value = aws_instance.web_server.id
}

