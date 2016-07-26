IMAGE_NAME=rickalm/pritunl

all: build

build:
	-docker kill pritunl
	-docker rm pritunl
	docker build -t $(IMAGE_NAME) .

clean:
	-docker kill pritunl
	-docker rm pritunl
	docker rmi $(IMAGE_NAME) || true

push: build
	docker push $(IMAGE_NAME)

run:
	-docker kill pritunl
	-docker rm pritunl
	docker run -d -t --privileged --net=host --name=pritunl -v "/var/lib/pritunl:/data" -e "PRITUNL_MONGODB_URI=${MONGODB_URI}" ${IMAGE_NAME}

test: build
	-docker kill pritunl
	-docker rm pritunl
	docker run -it --rm --privileged --net=host --name=pritunl -e "NNO_WEB=true" -e "PRITUNL_DEBUG=false" -v "/var/lib/pritunl:/data" -e "PRITUNL_MONGODB_URI=${MONGODB_URI}" ${IMAGE_NAME}

logs:
	docker logs -f pritunl
