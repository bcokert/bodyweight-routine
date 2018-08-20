
clean:
	rm -rf ./artifact

deps:
	go get .
	go get -t
	yarn --cwd frontend install

build-dev: clean build-webserver-dev build-frontend-dev

build-webserver-dev:
	rm -rf ./artifact/webserver
	mkdir -p ./artifact
	go build -o ./artifact/webserver ./cmd/webserver

build-frontend-dev:
	rm -rf ./artifact/static
	mkdir -p ./artifact/static
	yarn --cwd frontend webpack --env.development --config webpack.config.js --progress

watch-frontend-dev:
	rm -rf ./artifact/static
	mkdir -p ./artifact/static
	yarn --cwd frontend webpack --env.development --config webpack.config.js --progress --watch

run-dev:
	./artifact/webserver

build-production: clean build-webserver-production build-frontend-production

build-webserver-production:
	rm -rf ./artifact/webserver
	mkdir -p ./artifact
	env GOOS=linux GOARCH=amd64 go build -o ./artifact/webserver ./cmd/webserver

build-frontend-production:
	rm -rf ./artifact/static
	mkdir -p ./artifact/static
	yarn --cwd frontend webpack --env.production --config webpack.config.js --progress
