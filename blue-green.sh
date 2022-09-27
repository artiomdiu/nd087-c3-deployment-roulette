#!/bin/bash

set -e

function green_deploy {
  # NUM_OF_BLUE_PODS=$(kubectl get pods -n udacity | grep -c blue)
  # echo "BLUE PODS: $NUM_OF_BLUE_PODS"
  # NUM_OF_GREEN_PODS=$(kubectl get pods -n udacity | grep -c green)
  # echo "GREEN PODS: $NUM_OF_GREEN_PODS"

  # Check deployment rollout status every 1 second until complete.
  ROLLOUT_STATUS_CMD_GREEN="kubectl rollout status deployment/green -n udacity"
  until $ROLLOUT_STATUS_CMD_GREEN || [ $ATTEMPTS -eq 60 ]; do
    $ROLLOUT_STATUS_CMD_GREEN
    sleep 1
  done

  echo "Green deployment is successful"
}

# Initialize green deployment
kubectl apply -f starter/apps/blue-green/green.yml

sleep 1

# Begin green deployment
green_deploy
