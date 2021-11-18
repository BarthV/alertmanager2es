FROM golang:1.16-bullseye AS build
WORKDIR /app
COPY . ./
RUN go build -ldflags "-X main.revision=$(shell git describe --tags --always --dirty=-dev)"

FROM gcr.io/distroless/cc-debian11
WORKDIR /
COPY --from=build /app/alertmanager2es /
USER 65532:65532
ENTRYPOINT ["/alertmanager2es"]
