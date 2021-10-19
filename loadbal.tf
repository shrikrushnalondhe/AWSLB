provider "aws" {
  region = "us-east-1"
}

#Load Balancer#
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "3.0.0"
  # insert the 6 required variables here #

  name = "elb-demo"

  subnets         = ["subnet-03c334d465ef9d388", "subnet-0b896649d349b8532"]
  security_groups = ["sg-07ae7229bbbcbdfc0"]
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
    interval            = 10
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 6
  }

  ## access_logs = { ##
   ## bucket = "demo-access-log-bucket"##
  ##}##

  // ELB attachments
  number_of_instances = 2
  instances           = ["i-056a641837b893804", "i-0b28c0cda1d025802"]

  tags = {
   product = "demo"
  }
}
