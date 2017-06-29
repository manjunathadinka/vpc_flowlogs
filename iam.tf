resource "aws_iam_role" "vpc_to_cloudwatch" {
    name = "vpc_to_cloudwatch"
    assume_role_policy= <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
          "Sid": "",
          "Effect": "Allow",
          "Principal": {
            "Service": "vpc-flow-logs.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}


resource "aws_iam_policy" "iam_policy_for_vpc_flowlogs_to_assume" {
  name="iam_policy_for_vpc_flowlogs_to_assume"
  description = "aws iam policy for vpc flowlogs to allow cloudwatch log streaming"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
         {
              "Action": [
                  "logs:CreateLogGroup",
                  "logs:CreateLogStream",
                  "logs:DescribeLogGroups",
                  "logs:DescribeLogStreams",
                  "logs:PutLogEvents"
              ],
              "Effect": "Allow",
              "Resource": "*"
          }
      ]
  }
EOF
}
resource "aws_iam_role_policy_attachment" "attaching_policy_to_role" {
  role="${aws_iam_role.vpc_to_cloudwatch.name}"
  policy_arn="${aws_iam_policy.iam_policy_for_vpc_flowlogs_to_assume.arn}"
}
