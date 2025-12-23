#!/bin/bash

# Complete Fix and Start Script
# This will build images and start all services

set -e

echo "🔧 MYXCROW - Fix and Start All Services"
echo "========================================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check Docker
echo "📋 Step 1: Checking Docker..."
if ! docker ps > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not accessible!${NC}"
    echo "Please ensure Docker Desktop is running and shows 'Engine running'"
    exit 1
fi
echo -e "${GREEN}✅ Docker is accessible${NC}"
echo ""

# Navigate to project
cd "$(dirname "$0")"

# Free port 3000
echo "📋 Step 2: Freeing port 3000..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
sleep 1
echo -e "${GREEN}✅ Port 3000 is ready${NC}"
echo ""

# Stop existing containers
echo "📋 Step 3: Stopping existing containers..."
docker-compose -f infra/docker/docker-compose.dev.yml down 2>/dev/null || true
echo -e "${GREEN}✅ Cleaned up${NC}"
echo ""

# Build images first (this was the missing step!)
echo "📋 Step 4: Building Docker images..."
echo "   This may take a few minutes on first run..."
docker-compose -f infra/docker/docker-compose.dev.yml build --no-cache
echo -e "${GREEN}✅ Images built${NC}"
echo ""

# Start infrastructure
echo "📋 Step 5: Starting infrastructure services..."
docker-compose -f infra/docker/docker-compose.dev.yml up -d db redis minio mailpit
echo "⏳ Waiting for infrastructure..."
sleep 15
echo ""

# Start API
echo "📋 Step 6: Starting API service..."
docker-compose -f infra/docker/docker-compose.dev.yml up -d api
echo "⏳ Waiting for API..."
sleep 15
echo ""

# Start Web
echo "📋 Step 7: Starting Web service..."
docker-compose -f infra/docker/docker-compose.dev.yml up -d web
echo "⏳ Waiting for Web..."
sleep 10
echo ""

# Final status
echo "📊 Final Status:"
echo "================"
docker-compose -f infra/docker/docker-compose.dev.yml ps
echo ""

# Test services
echo "🧪 Testing services..."
echo ""
echo "API Health:"
curl -s http://localhost:4000/api/health 2>/dev/null || echo "   API starting..."
echo ""
echo "Web Status:"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 2>/dev/null || echo "000")
if [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "304" ]; then
    echo -e "   ${GREEN}✅ Web is running (HTTP $HTTP_CODE)${NC}"
else
    echo "   Web starting... (may take 30-60 seconds)"
fi
echo ""

echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "🌐 Access your services:"
echo "   - Web:  http://localhost:3000"
echo "   - API:  http://localhost:4000/api"
echo ""
echo "📋 View logs:"
echo "   docker-compose -f infra/docker/docker-compose.dev.yml logs -f"
echo ""

