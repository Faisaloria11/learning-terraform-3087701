provider "aws" {
  region = "us-east-1"  # Update with the desired AWS region
}

# Define the security group for the EC2 instance
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow inbound SSH traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH from anywhere (for production, restrict this)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define the EC2 instance resource
resource "aws_instance" "my_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # Update with the desired AMI ID (this is an example for Amazon Linux 2)
  instance_type = "t3.micro"  # Update with the desired instance type

  # Specify the security group to associate with the EC2 instance
  security_groups = [aws_security_group.allow_ssh.name]

  tags = {
    Name = "MyEC2Instance"
  }

  # Optionally, define a key pair if you want to SSH into the instance
  key_name = "your-key-name"  # Replace with your own key name, or leave it out if not needed
}

# Output the public IP of the instance
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}
