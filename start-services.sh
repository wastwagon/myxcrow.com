#!/bin/bash

# Simple script to start all MYXCROW services
# Run this after Docker Desktop is running

echo "🚀 Starting MYXCROW Services"
echo "============================"
echo ""

# Free port 3000 if needed
echo "📋 Checking port 3000..."
if lsof -ti:3000 > /dev/null 2>&1; then
    echo "   Freeing port 3000..."
    lsof -ti:3000 | xargs kill -9 2>/dev/null || true
    sleep 1
fi

# Navigate to project
cd "$(dirname "$0")"

# Start all services
echo "📋 Starting all services..."
docker-compose -f infra/docker/docker-compose.dev.yml up -d

# Wait a moment
echo "⏳ Waiting for services to start..."
sleep 10

# Show status
echo ""
echo "📊 Service Status:"
echo "=================="
docker-compose -f infra/docker/docker-compose.dev.yml ps

echo ""
echo "✅ Services are starting!"
echo ""
echo "🌐 Access your services:"
echo "   - Web:  http://localhost:3000"
echo "   - API:  http://localhost:4000/api"
echo ""
echo "⏳ Services may take 30-60 seconds to fully start."
echo "   Check Docker Desktop to see when containers are healthy."
echo ""

