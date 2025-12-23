# Docker Desktop Resource Settings Guide

## Current Issue

Docker Desktop Free Tier has resource limits that may be causing connection issues and build failures.

## Check Your Current Settings

### Via Docker Desktop UI:
1. Open Docker Desktop
2. Click the **Settings** (gear) icon
3. Go to **Resources** → **Advanced**
4. Check:
   - **Memory**: Should be at least 4GB
   - **CPUs**: Should be at least 4
   - **Disk image size**: Should be 20GB+

### Via Terminal:
```bash
cd /Users/OceanCyber/Downloads/myexrow
./check-docker-resources.sh
```

## Recommended Settings for MYXCROW

### Minimum (May have issues):
- **Memory**: 4GB
- **CPUs**: 2
- **Disk**: 20GB

### Recommended (Best performance):
- **Memory**: 8GB
- **CPUs**: 4
- **Disk**: 40GB

### Optimal (No issues):
- **Memory**: 12GB+
- **CPUs**: 6+
- **Disk**: 60GB+

## How to Adjust Settings

1. **Open Docker Desktop**
2. **Settings** → **Resources** → **Advanced**
3. **Adjust Memory:**
   - Drag slider to 4GB minimum (8GB recommended)
   - Click "Apply & Restart"
4. **Adjust CPUs:**
   - Set to at least 4 CPUs
   - Click "Apply & Restart"
5. **Wait for Docker Desktop to restart**
6. **Verify "Engine running" status**

## Why This Matters

- **Low Memory**: Causes Docker daemon to crash/disconnect
- **Low CPUs**: Makes builds extremely slow or fail
- **Low Disk**: Can't build images or run containers

## If You Can't Increase Resources

If your Mac doesn't have enough resources:

1. **Close other applications** (browsers, IDEs, etc.)
2. **Use minimum settings** (4GB RAM, 2 CPUs)
3. **Build one service at a time:**
   ```bash
   cd /Users/OceanCyber/Downloads/myexrow
   docker-compose -f infra/docker/docker-compose.dev.yml build api
   # Wait for it to finish
   docker-compose -f infra/docker/docker-compose.dev.yml build web
   # Wait for it to finish
   docker-compose -f infra/docker/docker-compose.dev.yml up -d
   ```
4. **Clean up Docker regularly:**
   ```bash
   docker system prune -a
   ```

## Check Current System Resources

```bash
# Check available RAM
sysctl hw.memsize

# Check CPU cores
sysctl -n hw.ncpu

# Check disk space
df -h
```

## After Adjusting Settings

1. **Restart Docker Desktop** (if it didn't auto-restart)
2. **Wait for "Engine running" status**
3. **Open a NEW terminal window**
4. **Run setup:**
   ```bash
   cd /Users/OceanCyber/Downloads/myexrow
   ./robust-setup.sh
   ```

---

**Most common issue: Memory set too low (default 2GB is often insufficient)**

