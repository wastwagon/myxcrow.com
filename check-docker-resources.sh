#!/bin/bash

# Check Docker Desktop Resource Usage and Limits

echo "🔍 Docker Desktop Resource Check"
echo "================================="
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if Docker is accessible
if ! docker ps > /dev/null 2>&1; then
    echo -e "${RED}❌ Docker is not accessible${NC}"
    echo ""
    echo "Please check Docker Desktop:"
    echo "1. Open Docker Desktop"
    echo "2. Go to Settings → Resources"
    echo "3. Check CPU and Memory allocation"
    echo ""
    exit 1
fi

echo -e "${GREEN}✅ Docker is accessible${NC}"
echo ""

# Check Docker system info
echo "📊 Docker System Information:"
echo "----------------------------"
docker system df
echo ""

# Check running containers
echo "📦 Running Containers:"
echo "---------------------"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Size}}"
echo ""

# Check Docker Desktop resource settings (if accessible)
echo "💾 Disk Usage:"
echo "-------------"
docker system df -v 2>/dev/null | head -20 || echo "Detailed info not available"
echo ""

# Recommendations
echo "💡 Recommendations for Docker Desktop Free Tier:"
echo "-----------------------------------------------"
echo ""
echo "1. Memory Settings:"
echo "   - Docker Desktop → Settings → Resources → Advanced"
echo "   - Recommended: 4GB RAM minimum"
echo "   - Current default: 2GB (may be too low)"
echo ""
echo "2. CPU Settings:"
echo "   - Allocate at least 2 CPUs"
echo "   - More CPUs = faster builds"
echo ""
echo "3. Disk Space:"
echo "   - Clean up unused images: docker system prune -a"
echo "   - Check available disk space"
echo ""
echo "4. If builds keep failing:"
echo "   - Increase memory to 4GB+"
echo "   - Increase CPUs to 4+"
echo "   - Close other applications"
echo ""

