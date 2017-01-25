all: build tag push

build:
	docker run --rm -v "$(CURDIR)/sqs-dead-letter-requeue:/src" -v /var/run/docker.sock:/var/run/docker.sock centurylink/golang-builder raisebook/sqs-dead-letter-requeue

tag:
	docker tag -f raisebook/sqs-dead-letter-requeue raisebook/sqs-dead-letter-requeue

push:
	docker push raisebook/sqs-dead-letter-requeue
