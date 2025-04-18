.PHONY: manual-up manual-test manual-down

manual-up: 
	@echo Checking if db_volume exists...
	@if not exist "$(shell docker volume ls --filter name=db_volume -q)" (docker volume create db_volume && echo db_volume created) else (echo db_volume already exists)
	@echo Cleaning up any existing containers, networks, and volumes...
	@$(MAKE) manual-down
	@echo Starting containers using manual Docker commands...
	@powershell -ExecutionPolicy Bypass -File ./setup_manual.ps1

manual-test:
	@echo Testing application...
	@echo Waiting for application to be ready...
	@for /L %%i in (1,1,5) do @( \
		echo Checking /health endpoint, attempt %%i... && \
		curl -s -o NUL -w "%%{http_code}" http://localhost:5423/health | findstr "200" >NUL && exit /b 0 || (timeout /t 5 >NUL) \
	) || (echo Application is not ready after 5 attempts. Exiting... && exit /b 1)
	@echo Testing /health endpoint:
	curl http://localhost:5423/health || echo Health check failed
	@echo \nTesting /data endpoint:
	curl http://localhost:5423/data || echo Data endpoint test failed

manual-down:
	@echo Stopping and removing containers, networks, and volumes...
	@if not "$(shell docker ps -a --filter name=mysql_container -q)"=="" ( \
		echo Stopping mysql_container && docker stop mysql_container && docker rm -f mysql_container \
	) else (echo mysql_container not running)
	@if not "$(shell docker ps -a --filter name=app_container -q)"=="" ( \
		echo Stopping app_container && docker stop app_container && docker rm -f app_container \
	) else (echo app_container not running)
	@if not "$(shell docker ps -a --filter name=nginx_container -q)"=="" ( \
		echo Stopping nginx_container && docker stop nginx_container && docker rm -f nginx_container \
	) else (echo nginx_container not running)
	@if not "$(shell docker network ls --filter name=db_network -q)"=="" ( \
		echo Removing db_network && docker network rm db_network \
	) else (echo db_network does not exist)
	@if not "$(shell docker network ls --filter name=site_network -q)"=="" ( \
		echo Removing site_network && docker network rm site_network \
	) else (echo site_network does not exist)
	
.PHONY: compose-up compose-test compose-down

compose-up: clean
	@echo Starting containers using Docker Compose...
	docker compose up --build -d

compose-test:
	@echo Testing application...
	@echo Testing /health endpoint:
	curl http://localhost:5423/health || echo Health check failed
	@echo \nTesting /data endpoint:
	curl http://localhost:5423/data || echo Data endpoint test failed

compose-down:
	@echo Stopping and removing Docker Compose resources...
	docker compose down -v

.PHONY: clean
clean:
	@echo Cleaning up all Docker resources...
	@docker rm -f $(docker ps -aq) 2>NUL || echo No containers to remove
	@docker network prune -f 2>NUL || echo No networks to prune
	@docker volume prune -f 2>NUL || echo No volumes to prune

.PHONY: help
help:
	@echo Available targets:
	@echo   manual-up    - Start containers using manual Docker commands
	@echo   manual-test  - Test the manually deployed application
	@echo   manual-down  - Clean up manual Docker resources
	@echo   compose-up   - Start containers using Docker Compose
	@echo   compose-test - Test the compose-deployed application
	@echo   compose-down - Clean up Docker Compose resources
	@echo   clean        - Clean up all Docker resources

.PHONY: run-all
run-all:
	@echo Running all targets sequentially...
	$(MAKE) manual-up
	$(MAKE) manual-test
	$(MAKE) manual-down
	$(MAKE) compose-up
	$(MAKE) compose-test
	$(MAKE) compose-down