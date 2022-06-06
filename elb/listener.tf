resource "aws_lb_listener" " elb_listener"front_end"{
    load_balancer_arn      = aws_lb.test.arn
    port                   =  80
    protocol               =  "TCP"
    default_action{   
        type               = "forward"
        target_group_arn  =  aws_lb_taregt_group.test.arn
    }
}