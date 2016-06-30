IMAGE_NAME=rickalm/pritunl

all:
	-docker kill pritunl
	-docker rm pritunl
	docker build -t $(IMAGE_NAME) .

clean:
	-docker kill pritunl
	-docker rm pritunl
	docker rmi $(IMAGE_NAME) || true

run:
	-docker kill pritunl
	-docker rm pritunl
	docker run -d -t --privileged --net=host --name=pritunl -e "MONGODB_URI=${MONGODB_URI}" ${IMAGE_NAME}

test:
	-docker kill pritunl
	-docker rm pritunl
	docker run -it --rm --privileged --net=host --name=pritunl -e "MONGODB_URI=${MONGODB_URI}" ${IMAGE_NAME}

logs:
	docker logs -f pritunl
