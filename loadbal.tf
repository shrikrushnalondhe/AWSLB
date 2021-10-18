provider "aws" {
  region = "us-east-1"
}

#Load Balancer#
module "elb_http" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = "elb-example"

  subnets         = ["subnet-0941bf30d4aa73d69", "subnet-05c8a9b7ec7aab601"]
  security_groups = ["sg-0888bfa2936ce81f9"]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
    {
      instance_port     = 443
      instance_protocol = "http"
      lb_port           = 443
      lb_protocol       = "http"
      ssl_certificate_id = "arn:aws:acm:eu-west-1:235367859451:certificate/6c270328-2cd5-4b2d-8dfd-ae8d0004ad31"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  access_logs = {
    bucket = "demo-access-log-bucket"
  }

  // ELB attachments
  number_of_instances = 2
  instances           = ["i-021ce51c8e99b3bef", "i-0d3795327779c4677"]

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}
