output "signup_url" {
  value = "${aws_apigatewayv2_stage.main.invoke_url}/signup"
}