# 🚀 SETUP INSTRUCTIONS - READ THIS

## The Problem

Your current terminal session **cannot access Docker** because it was opened before Docker Desktop started. This is a macOS limitation.

## ✅ THE SOLUTION (Only 2 Steps)

### Step 1: Open a NEW Terminal Window

**IMPORTANT:** You MUST open a **NEW** terminal window. Your current one won't work.

- Press `Cmd + T` (new tab) OR
- Press `Cmd + N` (new window) OR  
- Go to Terminal menu → New Window

### Step 2: Run This ONE Command

In the NEW terminal window, copy and paste this:

```bash
cd /Users/OceanCyber/Downloads/myexrow && ./DO_THIS_NOW.sh
```

That's it! The script will:
- ✅ Check Docker is accessible
- ✅ Free port 3000
- ✅ Build Docker images (3-5 minutes)
- ✅ Start all 6 services
- ✅ Show you the status

## Why This Happens

On macOS, terminal sessions opened **before** Docker Desktop starts don't get Docker environment variables. A **new** terminal window gets the current Docker environment.

## After Setup

Once the script completes, access:
- **Web**: http://localhost:3000
- **API**: http://localhost:4000/api

## Still Not Working?

If Docker still isn't accessible in the NEW terminal:

1. **Check Docker Desktop:**
   - Make sure it shows "Engine running" at the bottom
   - If not, wait for it to fully start

2. **Test Docker manually:**
   ```bash
   docker ps
   ```
   Should show containers or empty list (not an error)

3. **If `docker ps` works, then run:**
   ```bash
   cd /Users/OceanCyber/Downloads/myexrow
   ./DO_THIS_NOW.sh
   ```

---

**Remember: NEW terminal window is REQUIRED!**

