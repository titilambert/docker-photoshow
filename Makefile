VERSION=3.20170203

build:
	docker build -t photoshow .

run-it:
	docker run --rm --name photoshow -it --entrypoint bash photoshow

run:
	docker run --rm --name photoshow -p 80:80 photoshow 

push:
	docker tag photoshow titilambert/photoshow:latest
	docker tag photoshow titilambert/photoshow:$(VERSION)
	docker push titilambert/photoshow:latest
	docker push titilambert/photoshow:$(VERSION)
