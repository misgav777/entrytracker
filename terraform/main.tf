provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

# Create EC2 instance
resource "aws_instance" "web_server" {
  ami                    = "ami-053b12d3152c0cc71" # Ubuntu 20.04
  instance_type          = "t3a.small"
  key_name               = "develeap"
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  iam_instance_profile   = "SSMInstanceProfile"
  user_data              = file("user_data.sh")

  tags = {
    Name        = "${var.project_name}-instance"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Security Group
resource "aws_security_group" "web_server_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow SSH and HTTP inbound traffic"

  # Allow SSH access
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTP access
  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    Project     = var.project_name
  }
}