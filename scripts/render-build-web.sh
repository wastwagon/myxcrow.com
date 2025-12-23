#!/bin/bash
set -e

# Force install devDependencies by unsetting NODE_ENV
export NODE_ENV=""
# Install root dependencies first (for workspace)
pnpm install --no-frozen-lockfile
# Then build Web service
cd apps/web
pnpm build

