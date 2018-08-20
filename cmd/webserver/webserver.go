package main

import (
	"log"
	"net/http"
	"os"

	"github.com/bcokert/bodyweight-routine/internal/pkg/handler"
)

func main() {

	args := os.Args[1:]
	address := ":8080"
	staticFileRoot := "./artifact/static/"
	if len(args) > 0 && args[0] == "--production" {
		address = ":80"
		staticFileRoot = "/opt/bodyweight-routine/static/"
	}

	handler := &handler.RootHandler{
		StaticFileRoot: staticFileRoot,
		StatusHandler:  &handler.StatusHandler{},
		StaticHandler: &handler.StaticHandler{
			StaticFileRoot: staticFileRoot,
			FileServer:     http.FileServer(http.Dir(staticFileRoot)),
		},
	}
	log.Fatal(http.ListenAndServe(address, handler))
}
