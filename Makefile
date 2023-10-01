#!make
DB_SOURCE=postgresql://root:secret@localhost:5432/rdb?sslmode=disable

postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root rbd
dropdb:
	docker exec -it postgres dropdb rdb

migrateup:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up 1
migratedown:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

.PHONY: migrateup migratedown sqlc test