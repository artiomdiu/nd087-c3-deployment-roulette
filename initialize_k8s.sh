#!/bin/bash

set -e

kubectl apply -f starter/apps/hello-world
kubectl apply -f starter/apps/canary/index_v1_html.yml
kubectl apply -f starter/apps/canary/canary-v1.yml
kubectl apply -f starter/apps/blue-green

helm install kube-ops-view \
    stable/kube-ops-view \
    --set service.type=LoadBalancer \
    --set rbac.create=True
kubectl get svc kube-ops-view | tail -n 1 | awk '{ print "Kube-ops-view URL = http://"$4 }'

kubectl apply -f starter/apps/metrics-server
