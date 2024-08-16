FROM golang:1.22-alpine AS build
ARG TARGETARCH
RUN apk add --update git
RUN git clone https://github.com/CareyWang/MyUrls /app
WORKDIR /app
RUN go env -w GO111MODULE="on" && go env -w GOPROXY="https://goproxy.cn,direct"
RUN go mod tidy 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -ldflags="-s -w" -o myurls

FROM alpine:latest
WORKDIR /app
COPY --from=build /app/myurls ./
COPY public/* ./public/
COPY start.sh ./

COPY start.sh ./
RUN chmod +x start.sh

EXPOSE 8080

ENTRYPOINT ["/bin/sh", "/app/start.sh"]
