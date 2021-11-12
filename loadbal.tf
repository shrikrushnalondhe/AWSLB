provider "aws" {
  region = "us-east-1"
}

#Load Balancer#
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "3.0.0"
  # insert the 6 required variables here #

  name = "elb-demo"

  subnets         = ["subnet-0057fbf94fb8e357e", "subnet-009f8859d371590e9"]
  security_groups = ["sg-0b70a45765b71719f"]
  internal        = true

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },

    {
      instance_port     = 8081
      instance_protocol = "tcp"
      lb_port           = 8081
      lb_protocol       = "tcp"
    },

#    {#
 #     instance_port     = 443 #
  #    instance_protocol = "https" #
   #   lb_port           = 443 #
    #  lb_protocol       = "https" #
     # ssl_certificate_id = "arn:aws:acm:us-east-1:885270470374:certificate/d2b7948f-f15f-4a38-b17e-ab6247572580" #
   # },#
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 39
    healthy_threshold   = 10
    unhealthy_threshold = 9
    timeout             = 9
  }

  ## access_logs = { ##
   ## bucket = "demo-access-log-bucket"##
  ##}##

  // ELB attachments
  number_of_instances = 2
  instances           = ["i-08b5dbe2feb9dc941", "i-05665ec33d98b8733"]

  tags = {
   product = "demo"
  }
}
