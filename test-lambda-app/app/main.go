package main

import (
	"context"
	"errors"
	"fmt"
	"math/rand"

	"github.com/aws/aws-lambda-go/lambda"
)

func Handler(ctx context.Context) (string, error) {
	if rand.Intn(10) < 7 {
		fmt.Println("[WARN] some problem")
	}

	if rand.Intn(100) > 10 {
		return "", errors.New("error")
	}

	return "done", nil
}

func main() {
	lambda.Start(Handler)
}
