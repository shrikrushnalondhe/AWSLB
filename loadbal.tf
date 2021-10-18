provider "aws" {
  region = "us-east-1"
}

#Load Balancer#
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "3.0.0"
  # insert the 6 required variables here #

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
    
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  access_logs = {
    bucket = "arn:aws:s3:::demo-access-log-bucket"
  }

  // ELB attachments
  number_of_instances = 2
  instances           = ["i-021ce51c8e99b3bef", "i-0d3795327779c4677"]

  tags = {
   product = "demo"
  }
}
