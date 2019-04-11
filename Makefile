image = sqs-dead-letter-requeue:latest

all: install

build:
	mkdir -p ./bin
	go build -o bin/sqsrequeue cmd/sqsrequeue/main.go
install:
	cd cmd/sqsrequeue && go install
docker-build:
	docker build -t $(image) .
docker-push:
	docker push $(image)
