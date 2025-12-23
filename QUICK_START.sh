#!/bin/bash

# Quick Start - Does everything in one go while Docker is connected

set -e

echo "🚀 MYXCROW Quick Start"
echo "====================="
echo ""

# Set Docker socket
export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"

# Quick Docker test
if ! docker ps > /dev/null 2>&1; then
    echo "❌ Docker not accessible"
    echo ""
    echo "Run this in a NEW terminal after Docker Desktop shows 'Engine running':"
    echo "   cd /Users/OceanCyber/Downloads/myexrow"
    echo "   ./QUICK_START.sh"
    exit 1
fi

cd /Users/OceanCyber/Downloads/myexrow

# Do everything quickly while connection is active
echo "📋 Freeing port 3000..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true

echo "📋 Cleaning up..."
docker-compose -f infra/docker/docker-compose.dev.yml down 2>/dev/null || true

echo "📋 Building and starting (this takes 3-5 minutes)..."
docker-compose -f infra/docker/docker-compose.dev.yml build && \
docker-compose -f infra/docker/docker-compose.dev.yml up -d

echo "⏳ Waiting 20 seconds..."
sleep 20

echo ""
echo "📊 Status:"
docker-compose -f infra/docker/docker-compose.dev.yml ps

echo ""
echo "🎉 Done! Access:"
echo "   - Web: http://localhost:3000"
echo "   - API: http://localhost:4000/api"
echo ""

