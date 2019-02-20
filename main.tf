provider "aws" {
  region = "us-east-1"
}

variable "private_key_path" {
  default = "/home/jacob/.ssh/aws-jacobm-thinkpad.pem"
}

resource "aws_instance" "example" {
  # us-east-1 Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-0ac019f4fcb7cb7e6
  ami          = "ami-0ac019f4fcb7cb7e6"
  instance_type = "t2.small"
  count        = 1
  key_name = "jacobm-thinkpad"
  security_groups = ["jacobm-ubuntu-sg"]

  provisioner "file" {
    source      = "ubuntu-provisioner.sh"
    destination = "/tmp/ubuntu-provisioner.sh"
    connection {
      type = "ssh"
      user        = "ubuntu"
      private_key = "${file("${var.private_key_path}")}"
      timeout = "1m"
      agent = false
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/ubuntu-provisioner.sh",
      "sudo /tmp/ubuntu-provisioner.sh",
    ]
    connection {
      type = "ssh"
      user        = "ubuntu"
      private_key = "${file("${var.private_key_path}")}"
      timeout = "2m"
      agent = false
    }
  }


  tags = { 
    "owner" = "jacobm"
    "Name" = "jacobm-ubuntu"
    "TTL" = 99999
  }
}

output "Access to your VMs:" {
    value = "ssh -i ~/.ssh/aws-jacobm-thinkpad.pem ubuntu@${aws_instance.example.0.public_dns}"
}

