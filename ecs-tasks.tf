resource "aws_ecs_task_definition" "my_first_task" {
  family                   = "smartfleet-frontend-task" # Naming our first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "smartfleet-frontend-app",
      "image": "${aws_ecr_repository.repo_ecr.repository_url}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 1024,
      "cpu": 512
    }
  ]
  DEFINITION
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 1024         # Specifying the memory our container requires
  cpu                      = 512         # Specifying the CPU our container requires
  execution_role_arn       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
}