FROM golang:1.24 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o parcel-tracker .

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/parcel-tracker /app/parcel-tracker

CMD ["/app/parcel-tracker"]
