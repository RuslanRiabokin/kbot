FROM golang:1.21.4 as builder

WORKDIR /go/src/app
COPY . .
RUN go get
RUN make build

FROM busybox
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]


