#!make
DB_SOURCE=postgresql://root:secret@localhost:5432/RDB?sslmode=disable

postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=root --owner=root RBD
dropdb:
	docker exec -it postgres12 dropdb RBD

migrateup:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up 1
migratedown:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

.PHONY: migrateup migratedown sqlc test