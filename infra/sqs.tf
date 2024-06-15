resource "aws_sqs_queue" "sqs_queue" {
  name                        = "sqs-versioning-demo"
  delay_seconds               = 0
  visibility_timeout_seconds  = 60
  message_retention_seconds   = 86400
}

data "aws_iam_policy_document" "eventbridge_to_sqs" {
  statement {
    actions = ["sqs:SendMessage"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
    resources = [aws_sqs_queue.sqs_queue.arn]
  }
}

resource "aws_sqs_queue_policy" "sqs_versioning_demo_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id
  policy = data.aws_iam_policy_document.eventbridge_to_sqs.json
}