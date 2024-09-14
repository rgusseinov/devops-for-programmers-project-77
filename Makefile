dev:
	docker-compose up

test:
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

setup:
	docker-compose run app php artisan migrate

ci:
	docker-compose -f docker-compose.yml up -abort-on-container-exit


# docker-compose up ==> разворачивает среду для разработки.