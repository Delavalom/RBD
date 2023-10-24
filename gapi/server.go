package gapi

import (
	"fmt"

	db "github.com/Delavalom/RBD/db/sqlc"
	"github.com/Delavalom/RBD/pb"
	"github.com/Delavalom/RBD/token"
	"github.com/Delavalom/RBD/util"
	"github.com/Delavalom/RBD/worker"
)

// Server serves gRPC requests for our banking service.
type Server struct {
	pb.UnimplementedRBDServer
	config          util.Config
	store           db.Store
	tokenMaker      token.Maker
	taskDistributor worker.TaskDistributor
}

// NewServer creates a new gRPC server.
func NewServer(config util.Config, store db.Store, taskDistributor worker.TaskDistributor) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymmetricKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}
	server := &Server{
		config:          config,
		store:           store,
		tokenMaker:      tokenMaker,
		taskDistributor: taskDistributor,
	}

	return server, nil
}
