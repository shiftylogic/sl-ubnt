GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GORUN=$(GOCMD) run
GOTEST=$(GOCMD) test


all:	test build-cli-all

cli:
	$(GORUN) ./cmd/cli

build-cli-all: test-cli build-cli-linux build-cli-linux-arm build-cli-mac build-cli-mac-arm build-cli-win

build-cli-linux: cmd/cli/main.go
	env GOOS=linux GOARCH=amd64 $(GOBUILD) -o bin/linux/x64/ubnt-cli ./cmd/cli

build-cli-linux-arm: cmd/cli/main.go
	env GOOS=linux GOARCH=arm64 $(GOBUILD) -o bin/linux/arm/ubnt-cli ./cmd/cli

build-cli-mac: cmd/cli/main.go
	env GOOS=darwin GOARCH=amd64 $(GOBUILD) -o bin/mac/x64/ubnt-cli ./cmd/cli

build-cli-mac-arm: cmd/cli/main.go
	env GOOS=darwin GOARCH=arm64 $(GOBUILD) -o bin/mac/arm/ubnt-cli ./cmd/cli

build-cli-win: cmd/cli/main.go
	env GOOS=windows GOARCH=amd64 $(GOBUILD) -o bin/win/ubnt-cli.exe ./cmd/cli

test: test-cli test-pkg

test-cli:
	$(GOTEST) ./cmd/cli/...

test-pkg:
	$(GOTEST) ./pkg/...
