resource "aws_api_gateway_rest_api" "MyDemoAPI" {
  name        = "MyDemoAPI"
  description = "This is my API for demonstration purposes"
  tags = merge(
    local.config.tags,
    {
      "Name" : "MyDemoAPI"
    }
  )

  endpoint_configuration {
    types = [
      "REGIONAL",
    ]
  }
}

# /mydemoresource
resource "aws_api_gateway_resource" "MyDemoResource" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_rest_api.MyDemoAPI.root_resource_id
  path_part   = "mydemoresource"
}

# /mydemoresource/{resource-id}
resource "aws_api_gateway_resource" "MyDemoResourceId" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  parent_id   = aws_api_gateway_resource.MyDemoResource.id
  path_part   = "{resource-id}"
}

# GET /mydemoresource/{resource-id}
resource "aws_api_gateway_method" "MyDemoMethod" {
  rest_api_id   = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id   = aws_api_gateway_resource.MyDemoResourceId.id
  http_method   = "GET"
  authorization = "NONE"
  request_parameters = {
    "method.request.path.resource-id" = true
  }
}

# GET /endpoint/{thing-name} 호출 시 Param 정보를 DynamoDB Query에 추가
resource "aws_api_gateway_integration" "MyDemoIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id             = aws_api_gateway_resource.MyDemoResourceId.id
  http_method             = aws_api_gateway_method.MyDemoMethod.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  credentials             = "arn:aws:iam::${local.config.account}:role/${local.config.role_name}"
  passthrough_behavior    = "WHEN_NO_TEMPLATES"
  request_templates = {
    "application/json" = jsonencode(
      {
        "TableName" : "table",
        "Key" : {
          "thingName" : {
            "S" : "$input.params('resource-id')"
          }
        }
      }
    )
  }
  uri = "arn:aws:apigateway:ap-northeast-2:dynamodb:action/GetItem"
}

resource "aws_api_gateway_method_response" "response_200" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id = aws_api_gateway_resource.MyDemoResourceId.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "MyDemoIntegrationResponse" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  resource_id = aws_api_gateway_resource.MyDemoResourceId.id
  http_method = aws_api_gateway_method.MyDemoMethod.http_method
  status_code = aws_api_gateway_method_response.response_200.status_code
  response_templates = {
    "application/json" = <<EOF
#if($input.params('resource-id') == $input.path('$.Item').resourceId.S)
{
  "data": $input.path('$.Item').resourceData.S)
}
#else
{
  "data": "null"
}
#end
    EOF
  }
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.MyDemoAPI.id
  stage_name  = ""
}

resource "aws_api_gateway_stage" "example" {
  rest_api_id           = aws_api_gateway_rest_api.MyDemoAPI.id
  stage_name            = local.config.env
  cache_cluster_enabled = false
  deployment_id         = aws_api_gateway_deployment.example.id
}
