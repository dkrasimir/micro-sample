DOCKER_ORCHESTRATOR=kubernetes

all: build run

build: 
	./docker-build.sh

run:
	./docker-start.sh

clean:
	./docker-stop.sh

logs: 
	docker logs -f micro

curl:
	curl -i http://localhost:50080/micro-sample/rs/monitoring/ping

curl-loop:
	while true; do curl -i http://localhost:50080/micro-sample/rs/monitoring/ping; sleep 1; done

show:
	firefox http://localhost:50080/micro-sample/index.html

compose-up:
	docker-compose up -d

compose-down:
	docker-compose down

deploy-stack:
	docker stack deploy --compose-file docker-compose.yml micro-stack