#!make
DB_SOURCE=postgresql://root:secret@localhost:5432/rdb?sslmode=disable

postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root rbd
dropdb:
	docker exec -it postgres dropdb rdb

migrateup:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up
migratedown:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down

migrateup1:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up1
migratedown1:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down1

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/Delavalom/RBD/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock migrateup1 migratedown1