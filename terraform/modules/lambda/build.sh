#!/bin/bash
set -e

echo "Building Lambda package..."

docker build -t lambda-build .

docker run --rm -v "$(pwd):/out" lambda-build\
    bash -c "cd /var/task && zip -r /out/lambda.zip ."

echo "Done"