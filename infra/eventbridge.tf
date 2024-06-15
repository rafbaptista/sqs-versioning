resource "aws_cloudwatch_event_rule" "versioning-rule" {
  name        = "versioning-rule"
  description = "Triggers SQS on event versions equals to 1"
  event_pattern = <<EOF
  {
    "detail":{
        "Version": [1]
    }
  } 
  EOF
}

resource "aws_cloudwatch_event_target" "sqs" {
  rule      = aws_cloudwatch_event_rule.versioning-rule.name
  target_id = "SendToSQS"
  arn       =  aws_sqs_queue.sqs_queue.arn
  depends_on = [aws_sqs_queue.sqs_queue]
}