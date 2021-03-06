FROM golang:latest as builder

# create a working directory
WORKDIR /gin_test

COPY go.mod go.sum ./
RUN ls -a

# Download dependencies
RUN go mod tidy
RUN go mod download

COPY . .

## Build binary
#RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -a -installsuffix cgo -ldflags="-w -s" -o gin_test
RUN go build -o gin_test

# use a minimal alpine image for deployment
FROM alpine:latest
# add ca-certificates in case you need them
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
# set working directory
WORKDIR /root
# copy the binary from builder
COPY --from=builder /gin_test .
RUN touch .gin_test.yml

# Specify the PORT
EXPOSE 8080:8080

# run the binary
CMD ["./gin_test"]
