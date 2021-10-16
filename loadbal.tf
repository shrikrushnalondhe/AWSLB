#not working#
/*
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = "vpc-eecb1e85"
  subnets            = ["subnet-8b82a2c7", "subnet-8b82a2c7"]
  security_groups    = ["sg-07f69e000327985bd", "sg-07f69e000327985bd"]

  access_logs = {
    bucket = "my-alb-logs"
  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"

      targets = [
        {
          target_id = "i-044c72eae30af8e03"
          port = 80
        },
        {
          target_id = "i-045191384784a36b6"
          port = 80
        }
      ]
    }
  ]
}
*/
