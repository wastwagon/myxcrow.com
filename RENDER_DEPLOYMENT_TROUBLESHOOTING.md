# Render Deployment Troubleshooting Guide

## Common Issues and Solutions

### 1. Build Failures

#### Issue: `pnpm: command not found`
**Solution:** Render should have pnpm installed, but if not, add this to buildCommand:
```yaml
buildCommand: npm install -g pnpm && pnpm install --no-frozen-lockfile && cd services/api && pnpm prisma:generate && pnpm build
```

#### Issue: `Cannot find module` errors
**Solution:** Ensure root dependencies are installed first:
```yaml
buildCommand: pnpm install --no-frozen-lockfile && cd services/api && pnpm prisma:generate && pnpm build
```

#### Issue: Prisma generate fails
**Solution:** Prisma generate doesn't need DATABASE_URL, but ensure you're in the correct directory:
```bash
cd services/api && pnpm prisma:generate
```

### 2. Runtime Failures

#### Issue: Database connection errors
**Check:**
- DATABASE_URL is set correctly in Render dashboard
- Database service is running (should show "Available")
- Connection string format: `postgresql://user:password@host:port/database`

#### Issue: Redis connection errors
**Check:**
- REDIS_URL is set correctly (should be auto-populated from Redis service)
- Redis service is running (should show "Available")

#### Issue: Port binding errors
**Check:**
- PORT environment variable is set (4000 for API, 3000 for Web)
- Application listens on `0.0.0.0` not `localhost`

### 3. Checking Logs

#### View Build Logs:
1. Go to Render Dashboard
2. Click on the failed service (`myxcrow-api` or `myxcrow-web`)
3. Click "Logs" tab
4. Look for errors in the build output

#### View Runtime Logs:
1. Go to Render Dashboard
2. Click on the service
3. Click "Logs" tab
4. Scroll to see runtime errors

### 4. Manual Deployment Steps

If automatic deployment fails, try manual deploy:

1. **Check Build Logs:**
   ```bash
   # Look for specific error messages
   # Common issues:
   # - Missing dependencies
   # - Build script errors
   # - Environment variable issues
   ```

2. **Test Build Locally:**
   ```bash
   # Test API build
   pnpm install --no-frozen-lockfile
   cd services/api
   pnpm prisma:generate
   pnpm build
   
   # Test Web build
   cd ../../apps/web
   pnpm build
   ```

3. **Verify Environment Variables:**
   - DATABASE_URL (from database service)
   - REDIS_URL (from Redis service)
   - JWT_SECRET (auto-generated)
   - WEB_APP_URL (from web service)
   - S3 credentials (if using S3)
   - Paystack keys (if using Paystack)
   - Email credentials (if using email)

### 5. Current Configuration

#### API Service:
- **Build:** `pnpm install --no-frozen-lockfile && cd services/api && pnpm prisma:generate && pnpm build`
- **Start:** `cd services/api && pnpm prisma migrate deploy && node dist/main.js`
- **Port:** 4000
- **Health Check:** `/api/health`

#### Web Service:
- **Build:** `pnpm install --no-frozen-lockfile && cd apps/web && pnpm build`
- **Start:** `cd apps/web && pnpm start`
- **Port:** 3000
- **API URL:** `https://myxcrow-api.onrender.com/api`

### 6. Debugging Steps

1. **Check Service Status:**
   - Database: Should be "Available"
   - Redis: Should be "Available"
   - API: Check logs for errors
   - Web: Check logs for errors

2. **Verify Dependencies:**
   - Root `package.json` exists
   - `pnpm-workspace.yaml` exists
   - `services/api/package.json` exists
   - `apps/web/package.json` exists

3. **Check Prisma:**
   - `services/api/prisma/schema.prisma` exists
   - `services/api/prisma/migrations/` exists
   - Migration files are present

4. **Test Health Endpoints:**
   ```bash
   # After deployment, test:
   curl https://myxcrow-api.onrender.com/api/health
   # Should return: {"status":"ok"}
   ```

### 7. Quick Fixes

#### If API fails to start:
```bash
# Check if migrations ran
# Check DATABASE_URL is correct
# Check Redis is accessible
# Verify PORT is set to 4000
```

#### If Web fails to start:
```bash
# Check if build completed
# Verify NEXT_PUBLIC_API_BASE_URL is correct
# Check PORT is set to 3000
# Verify build output exists in .next folder
```

### 8. Environment Variables Checklist

**Required for API:**
- ✅ DATABASE_URL (auto from database)
- ✅ REDIS_URL (auto from Redis)
- ✅ JWT_SECRET (auto-generated)
- ✅ WEB_APP_URL (auto from web service)
- ⚠️ S3_ENDPOINT (manual - set if using S3)
- ⚠️ S3_ACCESS_KEY (manual - set if using S3)
- ⚠️ S3_SECRET_KEY (manual - set if using S3)
- ⚠️ PAYSTACK_SECRET_KEY (manual - set if using Paystack)
- ⚠️ PAYSTACK_PUBLIC_KEY (manual - set if using Paystack)
- ⚠️ EMAIL_HOST (manual - set if using email)
- ⚠️ EMAIL_USER (manual - set if using email)
- ⚠️ EMAIL_PASSWORD (manual - set if using email)

**Required for Web:**
- ✅ NEXT_PUBLIC_API_BASE_URL (set to API URL)
- ✅ NEXT_PUBLIC_ENV (set to "production")

### 9. Getting Help

If deployment still fails:
1. Copy the exact error message from Render logs
2. Check which step failed (build vs runtime)
3. Verify all environment variables are set
4. Test the build locally first
5. Check Render status page for service issues

