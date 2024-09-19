.DEFAULT_GOAL := deploy

fmt:
	go fmt ./...
.PHONY: fmt

lint: fmt
	golangci-lint run
.PHONY: lint

verify: fmt
	go vet ./...
	go mod verify
.PHONY: verify

clean:
	rm -rf ./.bin
.PHONY: clean

deploy: verify clean
	sls deploy --verbose
.PHONY: deploy
