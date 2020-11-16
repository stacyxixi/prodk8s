docker build -t stacyxixi/multi-client:lastest -t stacyxixi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t stacyxixi/multi-serve:lastest -t stacyxixi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t stacyxixi/multi-worker:lastest -t stacyxixi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Take those images and push them to docker hub
docker push stacyxixi/multi-client:latest
docker push stacyxixi/multi-client:$SHA
docker push stacyxixi/multi-server:latest
docker push stacyxixi/multi-server:$SHA
docker push stacyxixi/multi-worker:latest
docker push stacyxixi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stacyxixi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=stacyxixi/multi-worker:$SHA
kubectl set image deployments/client-deployment client=stacyxixi/multi-client:$SHA