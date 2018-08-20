package handler

import (
	"fmt"
	"log"
	"net/http"
)

func RespondJSON(handlerName string, status int, output []byte, res http.ResponseWriter) {
	res.WriteHeader(status)
	res.Header().Add("Content-Type", "application/json")

	_, err := res.Write(output)
	if err != nil {
		log.Print(fmt.Errorf("Error writing response in %s: %v", handlerName, err))
	}
}
