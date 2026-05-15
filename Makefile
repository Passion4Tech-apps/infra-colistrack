# Makefile pour ColisTrack

migrate:
	@echo "Verification des dossiers migrations..."
	@docker compose run --rm --entrypoint="" backend sh -c "\
		for app in users colis_app; do \
			if [ ! -d \"/app/\$$app/migrations\" ]; then \
				echo \"Creation migrations/ pour \$$app\"; \
				mkdir -p /app/\$$app/migrations; \
			fi; \
			if [ ! -f \"/app/\$$app/migrations/__init__.py\" ]; then \
				echo \"Creation __init__.py pour \$$app\"; \
				touch /app/\$$app/migrations/__init__.py; \
			fi; \
		done; \
		python manage.py makemigrations && python manage.py migrate"

restart:
	docker compose restart backend

logs:
	docker compose logs backend -f

shell:
	docker compose exec backend python manage.py shell

createsuperuser:
	docker compose exec backend python manage.py createsuperuser

seed:
	docker compose exec backend python manage.py seed

flush:
	docker compose exec backend python manage.py seed --flush

up:
	docker compose up -d

down:
	docker compose down

reset:
	docker compose down -v
	docker compose up -d

backup:
	bash /home/cyrus/p4t/colistrack/be-colistrack/scripts/backup.sh

exportjson:
	docker compose exec backend python manage.py export_json