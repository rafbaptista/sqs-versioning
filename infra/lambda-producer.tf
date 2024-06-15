data "archive_file" "artifacts-producer" {
type        = "zip"
source_dir  = "../artifacts/publish"
output_path = "../artifacts/publish.zip"
}
 
resource "aws_lambda_function" "producer_lambda_function" {
filename                       = data.archive_file.artifacts-producer.output_path
function_name                  = "producer-lambda-function"
role                           = aws_iam_role.lambda_role.arn
handler                        = "Producer::Producer.Function::FunctionHandler"
runtime                        = "dotnet6"
timeout                        = 120
source_code_hash               = data.archive_file.artifacts-producer.output_base64sha256
depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}