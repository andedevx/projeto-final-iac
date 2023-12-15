terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 3.27"
        }
      }

      required_version = ">= 0.14.9"
    }

    provider "aws" {
      profile = "default"
      region  = "us-east-1"
    }

    resource "aws_instance" "projeto-final" {
      ami           = "ami-0fc5d935ebf8bc3bc"
      instance_type = "t2.micro"
      key_name = "chave-projeto-final"

      vpc_security_group_ids = [
        "grupo-seguranca"
      ] 
    }

    resource "aws_key_pair" "chaveSSH" {
        key_name = "chave-projeto-final"
        public_key = file("./ssh/chave.pub")
    }

    resource "aws_security_group" "grupo-seguranca" {
      name = "grupo-seguranca"
      description = "grupo do Dev"
      ingress{
          cidr_blocks = [ "0.0.0.0/0" ]
          ipv6_cidr_blocks = [ "::/0" ]
          from_port = 0
          to_port = 0
          protocol = "-1"
      }
      egress{
          cidr_blocks = [ "0.0.0.0/0" ]
          ipv6_cidr_blocks = [ "::/0" ]
          from_port = 0
          to_port = 0
          protocol = "-1"
      }
      tags = {
        Name = "grupo-seguranca"
      }
    }

    output "IP_publico" {
      value = aws_instance.projeto-final.public_ip
    }