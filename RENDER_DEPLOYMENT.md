# Render Blueprint Deployment Guide

This guide will help you deploy MYXCROW to Render using the Blueprint configuration.

## 📋 Prerequisites

1. **GitHub Account** - Your code must be in a GitHub repository
2. **Render Account** - Sign up at [render.com](https://render.com)
3. **AWS S3 Account** (or compatible) - For file storage (MinIO alternative)
4. **Email Service** - SMTP credentials (SendGrid, Mailgun, etc.)
5. **Paystack Account** - Payment processing credentials

## 🚀 Deployment Steps

### Step 1: Push Code to GitHub

```bash
# Initialize git if not already done
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Ready for Render deployment"

# Add your GitHub remote (replace with your repo URL)
git remote add origin https://github.com/yourusername/myxcrow.git

# Push to GitHub
git push -u origin main
```

### Step 2: Connect to Render

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Blueprint"**
3. Connect your GitHub account if not already connected
4. Select your repository: `myxcrow`
5. Render will detect the `render.yaml` file automatically
6. Click **"Apply"**

### Step 3: Configure Environment Variables

Render will create all services from the blueprint. You need to configure these environment variables:

#### For `myxcrow-api` service:

**Required:**
- `JWT_SECRET` - Generate a strong secret (Render can auto-generate)
- `S3_ENDPOINT` - Your S3 endpoint (e.g., `https://s3.amazonaws.com` or `https://s3.us-east-1.amazonaws.com`)
- `S3_ACCESS_KEY` - Your AWS Access Key ID
- `S3_SECRET_KEY` - Your AWS Secret Access Key
- `S3_BUCKET` - Your S3 bucket name (default: `escrow-evidence`)
- `S3_REGION` - AWS region (e.g., `us-east-1`)
- `PAYSTACK_SECRET_KEY` - Your Paystack secret key
- `PAYSTACK_PUBLIC_KEY` - Your Paystack public key

**Email Configuration:**
- `EMAIL_HOST` - SMTP host (e.g., `smtp.sendgrid.net`)
- `EMAIL_PORT` - SMTP port (usually `587`)
- `EMAIL_USER` - SMTP username
- `EMAIL_PASSWORD` - SMTP password
- `EMAIL_FROM` - From email address (e.g., `noreply@myxcrow.com`)

**Optional:**
- `WEB_APP_URL` - Will be auto-set from the web service URL

#### For `myxcrow-web` service:

**Required:**
- `NEXT_PUBLIC_API_BASE_URL` - Will be auto-set, but you can override if needed

### Step 4: Update API Base URL

After deployment, update the `NEXT_PUBLIC_API_BASE_URL` in the web service:

1. Go to your `myxcrow-web` service
2. Navigate to **Environment**
3. Set `NEXT_PUBLIC_API_BASE_URL` to: `https://myxcrow-api.onrender.com/api`
   (Replace `myxcrow-api` with your actual API service name)

### Step 5: Run Database Migrations

The API service will automatically run migrations on startup via the `startCommand`:
```bash
pnpm prisma migrate deploy
```

If you need to run migrations manually:
1. Go to your `myxcrow-api` service
2. Open the **Shell** tab
3. Run:
```bash
cd services/api
pnpm prisma migrate deploy
```

### Step 6: Seed Database (Optional)

To seed test data:
1. Go to your `myxcrow-api` service
2. Open the **Shell** tab
3. Run:
```bash
cd services/api
pnpm seed
```

## 🔧 Service Configuration

### Database (PostgreSQL)
- **Type:** PostgreSQL
- **Plan:** Starter (can upgrade later)
- **Auto-backups:** Enabled by default

### Redis
- **Type:** Redis
- **Plan:** Starter
- **Memory Policy:** allkeys-lru

### API Service
- **Type:** Web Service
- **Build Command:** `cd services/api && pnpm install && pnpm prisma:generate && pnpm build`
- **Start Command:** `cd services/api && pnpm prisma migrate deploy && pnpm start`
- **Health Check:** `/api/health`

### Web Service
- **Type:** Web Service
- **Build Command:** `cd apps/web && pnpm install && pnpm build`
- **Start Command:** `cd apps/web && pnpm start`

## 🔐 Security Best Practices

1. **JWT_SECRET:** Use a strong, randomly generated secret (Render can auto-generate)
2. **Database:** Use Render's managed PostgreSQL (automatically secured)
3. **S3 Credentials:** Store in Render environment variables (encrypted)
4. **API Keys:** Never commit to git, use environment variables only

## 📊 Monitoring

Render provides:
- **Logs:** Real-time logs for each service
- **Metrics:** CPU, Memory, Request metrics
- **Alerts:** Email notifications for service issues
- **Health Checks:** Automatic health monitoring

## 🔄 Continuous Deployment

Render automatically deploys when you push to your connected branch:
- **Default branch:** `main` or `master`
- **Auto-deploy:** Enabled by default
- **Manual deploy:** Available in dashboard

## 🐛 Troubleshooting

### Build Failures

1. **Check logs:** Go to service → **Logs** tab
2. **Common issues:**
   - Missing dependencies → Check `package.json`
   - Prisma errors → Ensure `DATABASE_URL` is set
   - Build timeout → Increase build timeout in settings

### Database Connection Issues

1. Verify `DATABASE_URL` is correctly set (auto-configured from blueprint)
2. Check database is running and healthy
3. Verify network connectivity

### API Not Responding

1. Check health endpoint: `https://your-api.onrender.com/api/health`
2. Review API logs for errors
3. Verify all environment variables are set
4. Check Prisma migrations completed successfully

### Frontend Can't Connect to API

1. Verify `NEXT_PUBLIC_API_BASE_URL` is set correctly
2. Check CORS settings in API (should allow web service URL)
3. Verify API is running and healthy

## 📝 Environment Variables Reference

### API Service Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | Auto-set from database service |
| `REDIS_URL` | Redis connection string | Auto-set from Redis service |
| `JWT_SECRET` | Secret for JWT tokens | Auto-generated or custom |
| `S3_ENDPOINT` | S3-compatible storage endpoint | `https://s3.amazonaws.com` |
| `S3_ACCESS_KEY` | S3 access key | Your AWS access key |
| `S3_SECRET_KEY` | S3 secret key | Your AWS secret key |
| `S3_BUCKET` | S3 bucket name | `escrow-evidence` |
| `PAYSTACK_SECRET_KEY` | Paystack secret key | `sk_live_...` |
| `PAYSTACK_PUBLIC_KEY` | Paystack public key | `pk_live_...` |
| `EMAIL_HOST` | SMTP host | `smtp.sendgrid.net` |
| `EMAIL_USER` | SMTP username | Your SMTP username |
| `EMAIL_PASSWORD` | SMTP password | Your SMTP password |
| `EMAIL_FROM` | From email address | `noreply@myxcrow.com` |

### Web Service Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `NEXT_PUBLIC_API_BASE_URL` | API base URL | `https://myxcrow-api.onrender.com/api` |

## 🎯 Post-Deployment Checklist

- [ ] All services are running and healthy
- [ ] Database migrations completed successfully
- [ ] API health check returns `200 OK`
- [ ] Frontend loads and connects to API
- [ ] Environment variables are all set
- [ ] S3 storage is configured and accessible
- [ ] Email service is configured and tested
- [ ] Paystack credentials are set (production keys)
- [ ] Custom domain configured (optional)
- [ ] SSL certificates active (automatic on Render)

## 🔗 Useful Links

- [Render Documentation](https://render.com/docs)
- [Render Blueprints](https://render.com/docs/blueprint-spec)
- [Render Environment Variables](https://render.com/docs/environment-variables)

## 📞 Support

If you encounter issues:
1. Check Render service logs
2. Review this deployment guide
3. Check Render status page: https://status.render.com
4. Contact Render support through dashboard

---

**Ready to deploy?** Push your code to GitHub and connect it to Render!

