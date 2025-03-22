# Terraform Module: ECS Fargate Service

This Terraform module provisions an ECS Fargate service on AWS, integrated with an Application Load Balancer (ALB), Route 53 for DNS, IAM, Security Groups, and CloudWatch Logs. The module is designed to be reusable and configurable through variables.

## Provisioned Resources
- **AWS ECS Fargate Service**: An ECS service running in Fargate mode.
- **Task Definition**: Task definition with the specified container image.
- **IAM Role**: Execution role for ECS tasks.
- **Security Group**: SG for the ECS service, allowing internal VPC traffic.
- **Application Load Balancer (ALB)**: Target Group and Listener Rule to route traffic to the service.
- **Route 53**: CNAME record pointing to the ALB.
- **CloudWatch Logs**: Encrypted log group with KMS for container logs.
- **KMS Key**: Key for log encryption.

## Prerequisites
- Terraform `>= 1.0.0`.
- Providers:
  - `hashicorp/aws` `>= 4.18.0`
  - `hashicorp/random` `>= 3.6.3`
- A configured VPC with private subnets (tagged as `pvt-snet-1` and `pvt-snet-2`).
- An existing ECS cluster.
- An existing ALB listener (ARN must be provided).
- A configured Route 53 hosted zone.

## Usage
1. **Clone the repository** or copy the code into a directory.
2. **Configure variables**: Create a `terraform.tfvars` file or pass variables via CLI.
3. **Initialize Terraform**:
   ```bash
   terraform init
   ```
4. **Plan the execution**:
   ```bash
   terraform plan
   ```
5. **Apply the changes**:
   ```bash
   terraform apply
   ```

### Example Configuration
Create a `main.tf` file in the root directory to call the module:

```hcl
provider "aws" {
  region = "us-east-1"
}

module "ecs_fargate_service" {
  source          = "./"
  environment     = "prod"
  project         = "myapp"
  owner           = "devops"
  vpc_id          = "vpc-12345678"
  ecs_cluster_id  = "arn:aws:ecs:us-east-1:123456789012:cluster/my-cluster"
  app_port        = 8080
  cpu             = 256
  memory          = 512
  listener_arn    = "arn:aws:elasticloadbalancing:us-east-1:123456789012:listener/app/my-alb/abc123/def456"
  app_url         = "myapp.example.com"
  route53_zone_id = "Z1234567890"
  alb_cname       = "my-alb-1234567890.us-east-1.elb.amazonaws.com"
  health_check_path = "/health"
}
```

### Input Variables
| Name                | Type   | Description                                   | Default       |
|---------------------|--------|-----------------------------------------------|---------------|
| `environment`       | string | Environment (e.g., prod, dev)                | -             |
| `project`           | string | Project name                                 | -             |
| `owner`             | string | Owner of the resources                       | "terraform"   |
| `vpc_id`            | string | VPC ID                                       | -             |
| `ecs_cluster_id`    | string | ECS cluster ARN                              | -             |
| `app_port`          | number | Application port in the container            | -             |
| `cpu`               | number | CPU for the task (e.g., 256, 512)            | -             |
| `memory`            | number | Memory for the task (e.g., 512, 1024)        | -             |
| `listener_arn`      | string | ARN of the existing ALB listener             | -             |
| `app_url`           | string | Application URL (e.g., app.example.com)      | -             |
| `app_url_path`      | string | Path for the listener rule (optional)        | null          |
| `route53_zone_id`   | string | Route 53 hosted zone ID                      | -             |
| `alb_cname`         | string | ALB CNAME                                    | -             |
| `health_check_path` | string | Health check path                            | "/healthz"    |

### Outputs
- Task Definition ARN
- ECS Service Name
- Application URL

## Notes
- **Subnets**: The code assumes private subnets with specific tags (`pvt-snet-1`, `pvt-snet-2`). Adjust the filters in `data "aws_subnets" "private"` as needed.
- **Load Balancer**: The module expects an existing ALB and listener. It only creates the target group and listener rule.
- **Security**: The Security Group allows unrestricted outbound traffic (`0.0.0.0/0`). Adjust according to your security policies.
- **Logs**: Logs are retained for 7 days with KMS encryption. Modify `retention_in_days` to adjust.

## Development
This module was developed by [A9 Tecnologia](https://www.a9tech.com.br), a company specializing in innovative technology solutions.

## License
This project is licensed under the MIT License. See the [LICENSE](#license) section below for details.