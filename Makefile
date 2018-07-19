image = 038451313208.dkr.ecr.ap-southeast-2.amazonaws.com/sqs-dead-letter-requeue:latest

all: build push

build:
	docker build -t $(image) .

push:
	docker push $(image)
