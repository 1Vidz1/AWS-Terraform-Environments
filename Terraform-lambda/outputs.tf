output "api_endpoint" {
  description = "Endpoint of the api."

  value = aws_api_gateway_deployment.apideploy.invoke_url
}