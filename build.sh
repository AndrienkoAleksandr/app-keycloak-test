#!/bin/bash

docker build --no-cache -t docker.io/aandrienko/keyloack-js-adapters:latest .

docker push docker.io/aandrienko/keyloack-js-adapters:latest
