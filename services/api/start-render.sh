#!/bin/bash
set -e

cd services/api

# Run migrations
pnpm prisma migrate deploy

# Check if dist exists, if not rebuild
if [ -f dist/main.js ]; then
  echo "✅ dist/main.js found, starting..."
  node dist/main.js
else
  echo "❌ dist/main.js missing, rebuilding..."
  
  # Only install what's needed for build (production + build tools)
  # This avoids installing test dependencies which saves memory
  pnpm install --no-frozen-lockfile --prod=false --filter=api
  
  # Generate Prisma Client
  pnpm prisma:generate
  
  # Build with increased memory limit
  NODE_OPTIONS="--max-old-space-size=512" pnpm build
  
  # Verify build succeeded
  if [ ! -f dist/main.js ]; then
    echo "ERROR: Build failed - dist/main.js not found"
    exit 1
  fi
  
  echo "✅ Build successful, starting..."
  node dist/main.js
fi

