# Production Dockerfile for API
FROM node:20-alpine AS base

# Install pnpm
RUN npm install -g pnpm

# Install build dependencies
RUN apk add --no-cache python3 make g++ openssl

WORKDIR /usr/src/app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile --prod=false

# Copy source code
COPY . .

# Generate Prisma Client
RUN pnpm prisma:generate

# Build the application
RUN pnpm build

# Production stage
FROM node:20-alpine AS production

RUN npm install -g pnpm

WORKDIR /usr/src/app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install production dependencies only
RUN pnpm install --frozen-lockfile --prod

# Copy built application from base stage
COPY --from=base /usr/src/app/dist ./dist
COPY --from=base /usr/src/app/node_modules/.prisma ./node_modules/.prisma
COPY --from=base /usr/src/app/prisma ./prisma

# Expose port
EXPOSE 4000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD node -e "require('http').get('http://localhost:4000/api/health', (r) => {process.exit(r.statusCode === 200 ? 0 : 1)})"

# Start the application
CMD ["node", "dist/main.js"]

