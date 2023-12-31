#!make
DB_SOURCE=postgresql://root:secret@localhost:5432/rbd?sslmode=disable

postgres:
	docker run --name postgres --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
createdb:
	docker exec -it postgres createdb --username=root --owner=root rbd
dropdb:
	docker exec -it postgres dropdb rbd

migrateup:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up
migratedown:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down

migrateup1:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose up 1
migratedown1:
	migrate -path db/migrations -database "$(DB_SOURCE)" -verbose down 1

new_migration:
	migrate create -ext sql -dir db/migrations -seq $(name)

sqlc:
	sqlc generate

test:
	go test -v -cover -short ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/Delavalom/RBD/db/sqlc Store
	mockgen -package mockwk -destination worker/mock/distributor.go github.com/Delavalom/RBD/worker TaskDistributor

proto:
	rm -f pb/*.go
	rm -f public/docs/swagger/*.swagger.json
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	--openapiv2_out=public/docs/swagger --openapiv2_opt=allow_merge=true,merge_file_name=RBD \
    proto/*.proto
	statik -f -src=./public/docs/swagger -dest=./public/docs

evans:
	evans --host localhost --port 9090 -r repl

redis:
	docker run --name redis -p 6379:6379 -d redis:7-alpine

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock migrateup1 migratedown1 proto evans redis new_migration