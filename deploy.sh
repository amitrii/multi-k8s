docker build -t amitrii/multi-client:latest amitrii/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t amitrii/multi-server:latest amitrii/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t amitrii/multi-worker:latest amitrii/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push amitrii/multi-client:latest
docker push amitrii/multi-server:latest
docker push amitrii/multi-worker:latest
docker push amitrii/multi-client:$SHA
docker push amitrii/multi-server:$SHA
docker push amitrii/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amitrii/multi-server:$SHA
kubectl set image deployments/client-deployment client=amitrii/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=amitrii/multi-worker:$SHA