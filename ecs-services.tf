# resource "aws_ecs_service" "frontend_service" {
#   name            = "app-frontend"                             # Naming our first service
#   cluster         = "${aws_ecs_cluster.ecs_cluster.id}"             # Referencing our created Cluster
#   task_definition = "${aws_ecs_task_definition.my_first_task.arn}" # Referencing the task our service will spin up
#   launch_type     = "FARGATE"
#   desired_count   = 1 # Setting the number of containers we want deployed to 3

#   network_configuration {
#     subnets          = ["${aws_subnet.Public_subnet-a.id}", "${aws_subnet.Private_subnet-a.id}"]
#     assign_public_ip = true # Providing our containers with public IPs
#   }

#   load_balancer {
#     target_group_arn = "${aws_lb_target_group.target_group.arn}" # Referencing our target group
#     container_name   = "${aws_ecs_task_definition.my_first_task.family}"
#     container_port   = 80 # Specifying the container port
#   }
# }