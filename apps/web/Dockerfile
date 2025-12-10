# Production Dockerfile for Web
FROM node:20-alpine AS base

# Install pnpm
RUN npm install -g pnpm

WORKDIR /usr/src/app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

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
COPY --from=base /usr/src/app/.next ./.next
COPY --from=base /usr/src/app/public ./public
COPY --from=base /usr/src/app/next.config.js ./next.config.js
COPY --from=base /usr/src/app/package.json ./package.json

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000 || exit 1

# Start the application
CMD ["pnpm", "start"]

