package main

import (
	"context"
	"log"

	"github.com/Delavalom/RBD/api"
	db "github.com/Delavalom/RBD/db/sqlc"
	"github.com/Delavalom/RBD/util"
	"github.com/jackc/pgx/v5/pgxpool"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config")
	}
	conn, err := pgxpool.New(context.Background(), config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db")
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	if err != nil {
		log.Fatal("cannot start server", err)
	}

	err = server.Start("0.0.0.0:8080")

}
