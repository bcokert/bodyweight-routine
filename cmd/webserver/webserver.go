package main

import (
	"log"
	"net/http"

	"github.com/bcokert/bodyweight-routine/internal/pkg/handler"
)

func main() {

	staticFileRoot := "./artifact/static/"

	handler := &handler.RootHandler{
		StaticFileRoot: staticFileRoot,
		StatusHandler:  &handler.StatusHandler{},
		StaticHandler: &handler.StaticHandler{
			StaticFileRoot: staticFileRoot,
			FileServer:     http.FileServer(http.Dir(staticFileRoot)),
		},
	}
	log.Fatal(http.ListenAndServe(":8080", handler))
}
