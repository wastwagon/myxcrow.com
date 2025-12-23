# Pre-Deployment Checklist

Use this checklist before deploying to Render.

## ✅ Code Ready

- [x] All changes committed to git
- [x] `render.yaml` configured correctly
- [x] `.gitignore` updated
- [x] Documentation complete

## 📋 Before Pushing to GitHub

### 1. Verify Git Status
```bash
git status
# Should show "nothing to commit, working tree clean"
```

### 2. Review Changes
```bash
git log --oneline -5
# Review recent commits
```

### 3. Push to GitHub
```bash
git push origin main
```

## 🔧 Render Deployment Setup

### Required Environment Variables

Before deploying, prepare these values:

#### S3/Storage
- [ ] S3 endpoint URL
- [ ] S3 access key
- [ ] S3 secret key
- [ ] S3 bucket name (default: `escrow-evidence`)
- [ ] S3 region (default: `us-east-1`)

#### Payment Gateway
- [ ] Paystack secret key
- [ ] Paystack public key

#### Email Service
- [ ] SMTP host
- [ ] SMTP port (usually 587)
- [ ] SMTP username
- [ ] SMTP password
- [ ] From email address

### Auto-Configured (No Action Needed)
- ✅ `DATABASE_URL` - Auto-set from PostgreSQL
- ✅ `REDIS_URL` - Auto-set from Redis
- ✅ `JWT_SECRET` - Auto-generated
- ✅ `WEB_APP_URL` - Auto-set from web service

## 🚀 Deployment Steps

1. **Push to GitHub**
   ```bash
   git push origin main
   ```

2. **Connect to Render**
   - Go to https://dashboard.render.com
   - Click "New +" → "Blueprint"
   - Connect GitHub repository
   - Select repository: `myxcrow`

3. **Configure Environment Variables**
   - Set all required variables (see DEPLOYMENT_GUIDE.md)
   - Verify auto-configured variables

4. **Deploy**
   - Click "Apply"
   - Wait for services to build and deploy

5. **Verify Deployment**
   - Check API: `https://myxcrow-api.onrender.com/api/health`
   - Check Web: `https://myxcrow-web.onrender.com`

6. **Post-Deployment**
   - Update `NEXT_PUBLIC_API_BASE_URL` in web service
   - Run database migrations (if needed)
   - Seed database (optional)

## 📝 Important Notes

- **Service Names**: Render will create services named `myxcrow-api` and `myxcrow-web`
- **API URL**: After deployment, update `NEXT_PUBLIC_API_BASE_URL` to match your actual API URL
- **Database**: Migrations run automatically on API startup
- **Health Checks**: Both services have health check endpoints configured

## 🔗 Quick Links

- [Render Dashboard](https://dashboard.render.com)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)
- [Local Development Guide](LOCAL_DEVELOPMENT.md)

---

**Ready?** Push to GitHub and deploy! 🚀

