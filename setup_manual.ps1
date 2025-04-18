if (-not (docker network ls --filter name=db_network -q)) {
    docker network create db_network
}
if (-not (docker network ls --filter name=site_network -q)) {
    docker network create site_network
}

docker volume create db_volume

docker build -t mysql:latest -f mysql/Dockerfile .
docker build -t app:latest -f app/Dockerfile .

docker run -d `
    --name mysql_container `
    --network db_network `
    --network-alias mysql `
    -v db_volume:/var/lib/mysql `
    -e MYSQL_ROOT_PASSWORD=mysecretpassword `
    -e MYSQL_DATABASE=testdb `
    -p 3306:3306 `
    mysql:latest

Write-Host "Waiting for MySQL container to be healthy..."
for ($i = 0; $i -lt 5; $i++) {
    $health = docker inspect --format='{{.State.Health.Status}}' mysql_container
    if ($health -eq "healthy") {
        Write-Host "MySQL container is healthy."
        break
    }
    Start-Sleep -Seconds 5
    if ($i -eq 9) {
        Write-Host "MySQL container failed to become healthy. Exiting..."
        exit 1
    }
}

docker run -d `
    --name app_container `
    --network site_network `
    --network-alias app `
    -e DB_HOST=mysql `
    -e DB_PORT=3306 `
    -e MYSQL_ROOT_PASSWORD=mysecretpassword `
    -e MYSQL_DATABASE=testdb `
    app:latest

docker network connect db_network app_container

Write-Host "Waiting for App container to be healthy..."
for ($i = 0; $i -lt 5; $i++) {
    try {
        $health = docker inspect --format='{{.State.Health.Status}}' app_container
        if ($health -eq "healthy") {
            Write-Host "App container is healthy."
            break
        }
    } catch {
        Write-Host "Health status not available yet. Retrying..."
    }
    Start-Sleep -Seconds 5
    if ($i -eq 9) {
        Write-Host "App container failed to become healthy. Exiting..."
        exit 1
    }
}

docker run -d `
    --name nginx_container `
    --network site_network `
    -p 5423:80 `
    -v ${PWD}/nginx/conf/nginx.conf:/etc/nginx/nginx.conf:ro `
    nginx:latest

docker ps
