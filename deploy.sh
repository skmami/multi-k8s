docker build -t skmami/multi-client:latest -t skmami/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t skmami/multi-server:latest -t -t skmami/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t skmami/multi-worker:latest -t skmami/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push skmami/multi-client:latest
docker push skmami/multi-server:latest
docker push skmami/multi-worker:latest

docker push skmami/multi-client:$SHA
docker push skmami/multi-server:$SHA
docker push skmami/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=skmami/multi-server:$SHA
kubectl set image deployments/client-deployment client=skmami/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=skmami/multi-worker:$SHA

