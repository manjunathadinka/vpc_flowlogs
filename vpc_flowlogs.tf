resource "aws_cloudwatch_log_group" "cloudwatch_log_group_creation" {
    name = "/aws/vpcflowlogs/${var.vpc_flowlog_name}"
    tags {
      name="Vpc flowlogs"
    }
}

data "aws_vpc" "vpc_datasource" {
  id="${var.vpc_id}"
}

resource "aws_flow_log" "vpc_flow_log-creation" {
  log_group_name="${aws_cloudwatch_log_group.cloudwatch_log_group_creation.name}"
  iam_role_arn="${aws_iam_role.vpc_to_cloudwatch.arn}"
  vpc_id="${data.aws_vpc.vpc_datasource.id}"
  traffic_type="${var.aws_traffic_type}"
}
