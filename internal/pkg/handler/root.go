package handler

import (
	"fmt"
	"net/http"

	"github.com/bcokert/bodyweight-routine/internal/pkg/requesterror"
	"github.com/bcokert/bodyweight-routine/pkg/request"
)

type RootHandler struct {
	StaticFileRoot string
	StatusHandler  *StatusHandler
	StaticHandler  *StaticHandler
}

func (h *RootHandler) ServeHTTP(res http.ResponseWriter, req *http.Request) {
	var head string
	head, req.URL.Path = request.ShiftURL(req.URL.Path)

	switch head {
	case "":
		http.ServeFile(res, req, fmt.Sprintf("%s/index.html", h.StaticFileRoot))
	case "static":
		h.StaticHandler.ServeHTTP(res, req)
		return
	case "status":
		h.StatusHandler.ServeHTTP(res, req)
		return
	default:
		RespondJSON("Root", http.StatusNotFound, requesterror.PathNotFound("Root", head, req), res)
		return
	}
}
