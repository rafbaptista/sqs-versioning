data "archive_file" "artifacts-consumer" {
type        = "zip"
source_dir  = "../artifacts/publish"
output_path = "../artifacts/publish.zip"
}
 
resource "aws_lambda_function" "consumer_lambda_function" {
filename                       = data.archive_file.artifacts-consumer.output_path
function_name                  = "consumer-lambda-function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "Consumer::Consumer.Function::FunctionHandler"
runtime                        = "dotnet6"
timeout                        = 120
source_code_hash               = data.archive_file.artifacts-consumer.output_base64sha256
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  function_name    = aws_lambda_function.consumer_lambda_function.arn
}