docker build -t levantado/multi-client:latest -t levantado/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t levantado/multi-server:latest -t levantado/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t levantado/multi-worker:latest -t levantado/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push levantado/multi-client:latest
docker push levantado/multi-server:latest
docker push levantado/multi-worker:latest


docker push levantado/multi-client:$SHA
docker push levantado/multi-server:$SHA
docker push levantado/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=levantado/multi-server:$SHA
kubectl set image deployments/client-deployment client=levantado/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=levantado/multi-worker:$SHA
