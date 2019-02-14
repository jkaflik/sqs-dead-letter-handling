image = sqs-dead-letter-requeue:latest

all: build push

build:
	docker build -t $(image) .
push:
	docker push $(image)
