# MYXCROW Quick Reference

Quick commands and information for local development.

## 🚀 Start Everything

```bash
./setup-local.sh
```

## 🛑 Stop Everything

```bash
docker-compose -f infra/docker/docker-compose.dev.yml down
```

## 📊 Check Status

```bash
# Quick health check
./scripts/check-services.sh

# Detailed status
docker-compose -f infra/docker/docker-compose.dev.yml ps
```

## 📝 View Logs

```bash
# All services
docker-compose -f infra/docker/docker-compose.dev.yml logs -f

# Specific service
docker-compose -f infra/docker/docker-compose.dev.yml logs -f api
docker-compose -f infra/docker/docker-compose.dev.yml logs -f web
```

## 🌱 Seed Database

```bash
./scripts/db-seed.sh
```

## 🔄 Reset Database

```bash
./scripts/db-reset.sh
```

## 🔧 Common Tasks

### Run Database Migrations
```bash
docker exec escrow_api pnpm prisma migrate deploy
```

### Generate Prisma Client
```bash
docker exec escrow_api pnpm prisma generate
```

### Open Prisma Studio
```bash
docker exec escrow_api pnpm prisma studio
# Access at http://localhost:5555
```

### Access Database Shell
```bash
docker exec -it escrow_db psql -U postgres -d escrow
```

### Access API Container Shell
```bash
docker exec -it escrow_api sh
```

### Access Web Container Shell
```bash
docker exec -it escrow_web sh
```

## 🌐 URLs

- **Web:** http://localhost:3005
- **API:** http://localhost:4000/api
- **API Health:** http://localhost:4000/api/health
- **Mailpit:** http://localhost:8026
- **MinIO Console:** http://localhost:9004

## 🔑 Credentials

- **MinIO:** minioadmin / minioadmin
- **Database:** postgres / postgres (port 5434)
- **Admin:** admin@myxcrow.com / Admin123!

## 📚 Full Documentation

See [LOCAL_DEVELOPMENT.md](LOCAL_DEVELOPMENT.md) for complete guide.

