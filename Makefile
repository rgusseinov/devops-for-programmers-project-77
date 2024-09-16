dev:
	docker-compose up

test:
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci:
	docker-compose -f docker-compose.yml up -abort-on-container-exit


init:
	make -C terraform init

apply:
	make -C terraform apply

destroy:
	make -C terraform destroy

install:
	make -C ansible install

deploy:
	make -C ansible deploy
