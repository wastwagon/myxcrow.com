#!/bin/bash

# Database reset script for local development
# ⚠️ WARNING: This will delete all data!

set -e

echo "⚠️  WARNING: This will delete all database data!"
echo ""
read -p "Are you sure you want to continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cancelled."
    exit 0
fi

echo ""
echo "🔄 Resetting database..."

# Stop API service
docker-compose -f infra/docker/docker-compose.dev.yml stop api 2>/dev/null || true

# Remove database volume
docker-compose -f infra/docker/docker-compose.dev.yml down -v db 2>/dev/null || true

# Start database
docker-compose -f infra/docker/docker-compose.dev.yml up -d db

# Wait for database to be healthy
echo "⏳ Waiting for database to be ready..."
sleep 10

MAX_WAIT=60
WAIT_COUNT=0
while [ $WAIT_COUNT -lt $MAX_WAIT ]; do
    if docker exec escrow_db pg_isready -U postgres >/dev/null 2>&1; then
        break
    fi
    WAIT_COUNT=$((WAIT_COUNT + 5))
    sleep 5
done

# Start API to run migrations
docker-compose -f infra/docker/docker-compose.dev.yml up -d api

echo "⏳ Waiting for migrations to complete..."
sleep 15

echo ""
echo "✅ Database reset complete!"
echo ""
echo "💡 Run './scripts/db-seed.sh' to seed test data"

