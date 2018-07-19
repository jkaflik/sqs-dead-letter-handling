FROM golang:1.10.0-stretch AS built_app

ENV APP_NAME sqsrequeue

RUN mkdir -p /app/src/$APP_NAME /app/bin /app/pkg /root/.ssh

COPY src/$APP_NAME /app/src/$APP_NAME/

ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH:/app/bin/
ENV GOPATH $GOPATH:/app/
RUN go get github.com/golang/dep/cmd/dep

WORKDIR /app/src/$APP_NAME/
RUN dep ensure
ENV CGO_ENABLED=0
ENV GOOS=linux
RUN go build -a -ldflags '-extldflags "-static"' .


# Deployment artifact

FROM alpine:3.6
RUN apk add --update ca-certificates && rm -rf /var/cache/apk/*
COPY --from=built_app /app/src/sqsrequeue/sqsrequeue /sqs-dead-letter-requeue
ENTRYPOINT ["/sqs-dead-letter-requeue"]
