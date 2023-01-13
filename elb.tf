resource "aws_alb" "application_load_balancer" {
  name               = "smartfleet-elb"
  load_balancer_type = "application"
  subnets = [
     "${aws_subnet.Public_subnet-a.id}",
     "${aws_subnet.Public_subnet-b.id}"
     ]
  
  security_groups = ["${aws_security_group.http_sg.id}"]
  tags = var.common_tags
}

resource "aws_lb_target_group" "target_group" {
  name        = "target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = "${aws_vpc.smartfleet_vpc.id}" 
  health_check {
    matcher = "200,301,302"
    path = "/"
  }
  tags = var.common_tags
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = "${aws_alb.application_load_balancer.arn}" # Referencing our load balancer
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our tagrte group
  }

  tags = var.common_tags
}