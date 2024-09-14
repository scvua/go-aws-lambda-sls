.DEFAULT_GOAL := build

fmt:
	go fmt ./...
.PHONY: fmt

lint: fmt
	golangci-lint run
.PHONY: lint

vet: fmt
	go vet ./...
.PHONY: vet

verify: vet
	go mod verify
.PHONY: verify

build: verify
	GOARCH=amd64 GOOS=linux go build -tags lambda.norpc -o bin/hello/bootstrap hello/main.go
.PHONY: build

zip: build
	zip bin/hello.zip -j bin/hello/bootstrap
.PHONY: zip

clean:
	rm -rf ./bin
.PHONY: clean

deploy: clean zip
	sls deploy --verbose
.PHONY: deploy
