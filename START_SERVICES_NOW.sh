#!/bin/bash

# Start MYXCROW Services - Docker Desktop is Running
# This assumes Docker Desktop is already running and accessible

set -e

echo "🚀 Starting MYXCROW Services"
echo "============================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check Docker
echo "📋 Checking Docker..."
if ! docker ps > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker not accessible${NC}"
    echo ""
    echo "Please:"
    echo "1. Make sure Docker Desktop shows 'Engine running'"
    echo "2. Open a NEW terminal window"
    echo "3. Run this script again"
    exit 1
fi
echo -e "${GREEN}✅ Docker is accessible${NC}"
echo ""

# Navigate
cd "$(dirname "$0")"

# Free port 3000
echo "📋 Freeing port 3000..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
sleep 1

# Clean up
echo "📋 Cleaning up..."
docker-compose -f infra/docker/docker-compose.dev.yml down 2>/dev/null || true

# Build images
echo "📋 Building Docker images..."
echo "   This takes 3-5 minutes on first run..."
echo ""

echo "   Building API image..."
if ! docker-compose -f infra/docker/docker-compose.dev.yml build api; then
    echo -e "${RED}❌ API build failed${NC}"
    echo "   Check Docker Desktop for errors"
    exit 1
fi

echo "   Building Web image..."
if ! docker-compose -f infra/docker/docker-compose.dev.yml build web; then
    echo -e "${RED}❌ Web build failed${NC}"
    echo "   Check Docker Desktop for errors"
    exit 1
fi

echo -e "${GREEN}✅ Images built${NC}"
echo ""

# Start services
echo "📋 Starting all services..."
docker-compose -f infra/docker/docker-compose.dev.yml up -d

echo "⏳ Waiting for services to start..."
sleep 25

# Show status
echo ""
echo "📊 Service Status:"
echo "=================="
docker-compose -f infra/docker/docker-compose.dev.yml ps
echo ""

# Test
echo "🧪 Testing services..."
sleep 5

if curl -s http://localhost:4000/api/health > /dev/null 2>&1; then
    echo -e "${GREEN}✅ API is healthy${NC}"
else
    echo -e "${YELLOW}⚠️  API starting...${NC}"
fi

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 2>/dev/null || echo "000")
if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "304" ]; then
    echo -e "${GREEN}✅ Web is running${NC}"
else
    echo -e "${YELLOW}⚠️  Web starting...${NC}"
fi
echo ""

echo "🎉 Services Started!"
echo "==================="
echo ""
echo "🌐 Access:"
echo "   - Web: http://localhost:3000"
echo "   - API: http://localhost:4000/api"
echo ""
echo "📋 View in Docker Desktop:"
echo "   You should now see 6 escrow containers:"
echo "   - escrow_db"
echo "   - escrow_redis"
echo "   - escrow_minio"
echo "   - escrow_mailpit"
echo "   - escrow_api"
echo "   - escrow_web"
echo ""

