#Web_server_instance
resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.vpc_sg_id]
  key_name = "NayaWala"
  tags = {
    Name = "Web_Server"
  }
  provisioner "local-exec" {
  command = "echo [webserver] > ${path.root}/ansible/hosts.ini && echo ${self.private_ip} ansible_user=ubuntu ansible_ssh_private_key_file=${path.root}/NayaWala >> ${path.root}/ansible/hosts.ini"
  }
}

output "web_instance_id" {
  value = aws_instance.web_server.id
}

