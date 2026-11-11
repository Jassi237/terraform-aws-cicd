#!/bin/bash

set -e

echo "Starting website deployment"

sudo cp website/index.html /var/www/html/index.html

echo "Website deployed successfully"