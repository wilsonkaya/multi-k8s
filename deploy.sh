docker build -t fatihkaya2/multi-client:latest -t fatihkaya2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fatihkaya2/multi-server:latest -t fatihkaya2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fatihkaya2/multi-worker:latest -t fatihkaya2/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push fatihkaya2/multi-client:latest
docker push fatihkaya2/multi-server:latest
docker push fatihkaya2/worker:latest

docker push fatihkaya2/multi-client:$SHA
docker push fatihkaya2/multi-server:$SHA
docker push fatihkaya2/worker:$SHA

kubectl apply -f k8s 
kubectl set image deployments/server-deployment server=fatihkaya2/multi-server:$SHA 
kubectl set image deployments/client-deployment client=fatihkaya2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=fatihkaya2/multi-worker:$SHA