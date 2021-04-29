docker build -t premkgdocker/multi-container-client:latest -t premkgdocker/multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t premkgdocker/multi-container-server:latest -t premkgdocker/multi-container-server:$SHA -f ./server/Dockerfile ./server
docker build -t premkgdocker/multi-container-worker:latest -t premkgdocker/multi-container-worker:$SHA -f ./worker/Dockerfile ./worker

docker push premkgdocker/multi-container-client:latest
docker push premkgdocker/multi-container-server:latest
docker push premkgdocker/multi-container-worker:latest

docker push premkgdocker/multi-container-client:$SHA
docker push premkgdocker/multi-container-server:$SHA
docker push premkgdocker/multi-container-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=premkgdocker/multi-container-server:$SHA
kubectl set image deployments/client-deployment client=premkgdocker/multi-container-client:$SHA
kubectl set image deployments/worker-deployment worker=premkgdocker/multi-container-worker:$SHA