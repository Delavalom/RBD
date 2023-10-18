# Build stage
FROM golang:1.21.2-alpine3.18 AS build
WORKDIR /app
COPY . .
RUN go build -o main main.go

# Run stage
FROM alpine:3.18
WORKDIR /app
COPY --from=build /app/main .
COPY app.env .
COPY start.sh .
COPY wait-for.sh .
COPY db/migrations ./db/migrations

EXPOSE 8080
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]