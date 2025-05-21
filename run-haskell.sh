#!/bin/bash

# Usage: ./run-haskell.sh chapter01

if [ -z "$1" ]; then
  echo "❌ Please specify the folder name (e.g., chapter01)"
  exit 1
fi

# TODO 
# PROJECT_ROOT=""
PROJECT_DIR="$PROJECT_ROOT/$1"

if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ Project directory '$PROJECT_DIR' does not exist."
  exit 1
fi

echo "🚀 Starting container for project: $1"
docker run \
  -ti \
  --mount type=bind,source="$PROJECT_DIR",target=/work \
  my-haskell-env \
  bash