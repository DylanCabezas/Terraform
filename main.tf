provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami           = "ami-0e68426dec8cb536b"  
  instance_type = "t2.micro"
  key_name      = "vockey"

  # Asociar el grupo de seguridad por ID
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  # Configuración del disco
  root_block_device {
    volume_size = 20  # Tamaño del disco en GB
  }

  tags = {
    Name = "MyEC2Instance"
  }
}
