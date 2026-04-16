resource "aws_instance" "jenkins" {
  ami           = "ami-0f5ee92e2d63afc18" # Ubuntu (ap-south-1)
  instance_type = "t3.micro"
  key_name      = "trends"

  subnet_id = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y openjdk-17-jdk docker.io git

              systemctl start docker
              systemctl enable docker

              # Jenkins install
              wget -O /usr/share/keyrings/jenkins-keyring.asc \
              https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
              https://pkg.jenkins.io/debian-stable binary/ > \
              /etc/apt/sources.list.d/jenkins.list

              apt update -y
              apt install -y jenkins

              systemctl start jenkins
              systemctl enable jenkins

              usermod -aG docker ubuntu
              usermod -aG docker jenkins
              EOF

  tags = {
    Name = "Jenkins-Server"
  }
}
