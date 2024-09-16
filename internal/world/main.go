package main

import (
	"bytes"
	"context"
	"encoding/json"
	"net/http"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

type Response events.APIGatewayProxyResponse

func Handler(ctx context.Context) (Response, error) {
	var buf bytes.Buffer

	body, err := json.Marshal(map[string]any{
		"message": "Go Serverless v4.3.2: world",
	})
	if err != nil {
		return Response{StatusCode: http.StatusNotFound}, err
	}
	json.HTMLEscape(&buf, body)

	resp := Response{
		StatusCode:      http.StatusOK,
		IsBase64Encoded: false,
		Body:            buf.String(),
		Headers: map[string]string{
			"Content-Type":           "application/json",
			"X-MyCompany-Func-Reply": "world-handler",
		},
	}

	return resp, nil
}

func main() {
	lambda.Start(Handler)
}
