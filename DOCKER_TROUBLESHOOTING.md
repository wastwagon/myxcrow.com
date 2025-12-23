# Docker Troubleshooting Guide

## Issue: "Cannot connect to the Docker daemon"

This error means Docker Desktop is either not running or not fully initialized.

## Solutions

### Solution 1: Verify Docker Desktop is Running

1. **Check Docker Desktop Status:**
   - Look for the Docker whale icon in your Mac menu bar (top right)
   - It should show "Docker Desktop is running"
   - If you see "Docker Desktop is starting...", wait for it to finish

2. **Open Docker Desktop:**
   - Click the Docker icon in Applications
   - Or press `Cmd + Space` and type "Docker Desktop"
   - Wait until you see "Engine running" at the bottom

3. **Verify in Terminal:**
   ```bash
   docker ps
   ```
   Should show a list of containers (or empty list if no containers running)

### Solution 2: Restart Docker Desktop

1. **Quit Docker Desktop completely:**
   - Click Docker icon in menu bar
   - Select "Quit Docker Desktop"
   - Wait 10 seconds

2. **Restart Docker Desktop:**
   - Open Docker Desktop from Applications
   - Wait for "Engine running" status

3. **Try again:**
   ```bash
   cd /Users/OceanCyber/Downloads/myexrow
   ./quick-setup.sh
   ```

### Solution 3: Check Docker Socket Path

Sometimes Docker uses a different socket path. Try:

```bash
# Check if socket exists
ls -la ~/.docker/run/docker.sock
ls -la /var/run/docker.sock

# If socket doesn't exist, Docker Desktop isn't running
```

### Solution 4: Use Docker Desktop Terminal

1. Open Docker Desktop
2. Go to Settings → Resources → Advanced
3. Or use the built-in terminal in Docker Desktop

### Solution 5: Manual Verification Steps

Run these commands to verify Docker:

```bash
# 1. Check Docker version
docker --version

# 2. Check if Docker daemon is accessible
docker info

# 3. List containers
docker ps

# 4. If all above work, try docker-compose
docker-compose --version
```

## Expected Output

When Docker is working correctly:

```bash
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

Or if containers are running, you'll see a list.

## Once Docker is Working

After Docker Desktop is running and accessible:

```bash
cd /Users/OceanCyber/Downloads/myexrow
./quick-setup.sh
```

This will start all services:
- ✅ PostgreSQL (port 5434)
- ✅ Redis (port 6380)
- ✅ MinIO (ports 9003, 9004)
- ✅ Mailpit (ports 1026, 8026)
- ✅ API (port 4000)
- ✅ Web (port 3000)

## Still Having Issues?

1. **Check Docker Desktop logs:**
   - Docker Desktop → Troubleshoot → View logs

2. **Reset Docker Desktop:**
   - Docker Desktop → Settings → Troubleshoot → Reset to factory defaults
   - ⚠️ This will remove all containers and images

3. **Reinstall Docker Desktop:**
   - Download from https://www.docker.com/products/docker-desktop
   - Uninstall current version first

## Quick Test

Run this to test Docker connectivity:

```bash
docker run hello-world
```

If this works, Docker is functioning correctly!

