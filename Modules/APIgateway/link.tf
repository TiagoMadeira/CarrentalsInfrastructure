resource "aws_apigatewayv2_vpc_link" "eks" {
  name               = "eks"
  security_group_ids = [aws_security_group.vpc-link.id]
  subnet_ids         = [var.subnet_private_zone1_id,var.subnet_private_zone2_id]

  tags = {
    Usage = "example"
  }
}

resource "aws_apigatewayv2_integration" "eks" {
  api_id                = aws_apigatewayv2_api.main.id

  integration_uri       = var.integration_uri
  integration_type      = "HTTP_PROXY"
  integration_method    = "ANY"
  connection_type       = "VPC_LINK"
  connection_id         = aws_apigatewayv2_vpc_link.eks.id
}

resource "aws_apigatewayv2_route" "example" {
  api_id        = aws_apigatewayv2_api.main.id
  route_key     = "$default"
  target        = "integrations/${aws_apigatewayv2_integration.eks.id}"
}

resource "aws_apigatewayv2_route" "post_signup" {
  api_id        = aws_apigatewayv2_api.main.id
  route_key     = "POST /v1/signup"
  target        = "integrations/${aws_apigatewayv2_integration.eks.id}"
}

resource "aws_apigatewayv2_route" "get_health_check" {
  api_id        = aws_apigatewayv2_api.main.id
  route_key     = "GET /v1/up"
  target        = "integrations/${aws_apigatewayv2_integration.eks.id}"
}


