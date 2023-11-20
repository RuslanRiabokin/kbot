VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux

format:
	gofmt -s -w ./

lint:
	go install golang.org/x/lint/golint
	golint

test:
	go test -v

linux: format
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/RuslanRiabokin/kbot_kbot/cmd.appVersion=${VERSION}

windows: format
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o kbot.exe -ldflags "-X="github.com/RuslanRiabokin/kbot_kbot/cmd.appVersion=${VERSION}

macos: format
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o kbot -ldflags "-X="github.com/RuslanRiabokin/kbot_kbot/cmd.appVersion=${VERSION}

arm: format
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -v -o kbot -ldflags "-X="github.com/RuslanRiabokin/kbot_kbot/cmd.appVersion=${VERSION}

clean:
	rm -rf kbot kbot.exe