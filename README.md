# MYXCROW - Escrow Platform

A comprehensive escrow platform built with Next.js and NestJS, designed for secure transactions in Ghana.

## 🚀 Quick Start

### Prerequisites
- **Docker Desktop** (v20.10+)
- **Docker Compose** (v2.0+ or v1.29+)

### Automated Setup (Recommended)

Run the setup script to start all services:

```bash
./setup-local.sh
```

This will automatically:
- ✅ Check Docker is running
- ✅ Start all infrastructure services (PostgreSQL, Redis, MinIO, Mailpit)
- ✅ Run database migrations
- ✅ Start API and Web services
- ✅ Verify all services are healthy

### Manual Setup

Alternatively, start services manually:

```bash
docker-compose -f infra/docker/docker-compose.dev.yml up -d
```

### Access the Application

Once services are running:

- **Frontend:** http://localhost:3005 (Note: Port 3005 used due to port 3000 being in use)
- **API:** http://localhost:4000/api
- **API Health:** http://localhost:4000/api/health
- **Mailpit (Email):** http://localhost:8026
- **MinIO Console:** http://localhost:9004 (minioadmin/minioadmin)

### Seed Test Data

After starting services, seed the database with test data:

```bash
./scripts/db-seed.sh
```

Or manually:
```bash
docker exec escrow_api pnpm seed
```

## 📁 Project Structure

```
myexrow/
├── apps/
│   └── web/              # Next.js frontend
├── services/
│   └── api/              # NestJS backend
├── infra/
│   └── docker/           # Docker configuration
└── packages/
    └── types/            # Shared TypeScript types
```

## 🔑 Test Accounts

### Admin
- **Email:** `admin@myxcrow.com`
- **Password:** `Admin123!`

### Test Users (Password: `password123`)
- Buyers: `buyer1@test.com` through `buyer5@test.com`
- Sellers: `seller1@test.com` through `seller5@test.com`

## 📚 Documentation

- **[Local Development Guide](LOCAL_DEVELOPMENT.md)** - Complete guide for local setup and development
- [Product Review](PRODUCT_REVIEW.md) - Complete feature overview
- [Implementation Summary](README_IMPLEMENTATION.md) - Detailed implementation guide

## 🛠️ Development

### Using Docker (Recommended)

All services run in Docker containers with hot-reload enabled. See [LOCAL_DEVELOPMENT.md](LOCAL_DEVELOPMENT.md) for complete details.

**Quick Commands:**
```bash
# Start all services
./setup-local.sh

# View logs
docker-compose -f infra/docker/docker-compose.dev.yml logs -f

# Stop services
docker-compose -f infra/docker/docker-compose.dev.yml down

# Seed database
./scripts/db-seed.sh

# Check service health
./scripts/check-services.sh
```

### Local Development (Without Docker)

If you prefer to run services locally:

**Backend (API):**
```bash
cd services/api
pnpm install
pnpm dev
```

**Frontend (Web):**
```bash
cd apps/web
pnpm install
pnpm dev
```

**Note:** You'll need to set up PostgreSQL, Redis, and MinIO separately for local development.

## 📄 License

Private - All Rights Reserved
