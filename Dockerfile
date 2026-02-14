# Build stage
FROM golang:1.23 AS builder
WORKDIR /app
COPY go.mod main.go ./
COPY templates/ templates/
RUN CGO_ENABLED=0 go build -o app .

# Final stage
FROM scratch
COPY --from=builder /app/app .
COPY --from=builder /app/templates/ templates/
CMD ["./app"]
