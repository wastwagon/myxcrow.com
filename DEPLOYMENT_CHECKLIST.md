# Pre-Deployment Checklist

Use this checklist before deploying to Render.

## 📋 Code Preparation

- [ ] All code is committed to Git
- [ ] Code is pushed to GitHub
- [ ] `render.yaml` is in the root directory
- [ ] `.gitignore` includes `.env` files
- [ ] No sensitive data in code (API keys, secrets, etc.)

## 🔧 Configuration Files

- [ ] `render.yaml` is configured correctly
- [ ] Production Dockerfiles exist (`services/api/Dockerfile`, `apps/web/Dockerfile`)
- [ ] `package.json` scripts are updated for production
- [ ] Environment variable examples in `.env.example`

## 🗄️ Database

- [ ] Prisma schema is up to date
- [ ] Migrations are ready (`prisma migrate deploy`)
- [ ] Seed script is tested (optional)

## 🔐 External Services Setup

### AWS S3 (or compatible)
- [ ] S3 bucket created: `escrow-evidence`
- [ ] IAM user created with S3 access
- [ ] Access key and secret key obtained
- [ ] Bucket CORS configured (if needed)

### Email Service (SMTP)
- [ ] SMTP service account created (SendGrid, Mailgun, etc.)
- [ ] SMTP credentials obtained
- [ ] From email address configured

### Paystack
- [ ] Paystack account created
- [ ] Production API keys obtained
- [ ] Webhook URL configured (if needed)

## 🌐 Domain & URLs

- [ ] Decide on service names in Render
- [ ] Note the URLs that will be generated:
  - API: `https://myxcrow-api.onrender.com`
  - Web: `https://myxcrow-web.onrender.com`
- [ ] Custom domain ready (optional)

## 📝 Environment Variables List

Prepare these values before deployment:

### API Service
- [ ] `JWT_SECRET` (generate strong secret)
- [ ] `S3_ENDPOINT`
- [ ] `S3_ACCESS_KEY`
- [ ] `S3_SECRET_KEY`
- [ ] `S3_BUCKET`
- [ ] `S3_REGION`
- [ ] `PAYSTACK_SECRET_KEY`
- [ ] `PAYSTACK_PUBLIC_KEY`
- [ ] `EMAIL_HOST`
- [ ] `EMAIL_PORT`
- [ ] `EMAIL_USER`
- [ ] `EMAIL_PASSWORD`
- [ ] `EMAIL_FROM`

### Web Service
- [ ] `NEXT_PUBLIC_API_BASE_URL` (will be set after API deploys)

## ✅ Testing

- [ ] Local build works: `cd services/api && pnpm build`
- [ ] Frontend build works: `cd apps/web && pnpm build`
- [ ] Database migrations work locally
- [ ] All tests pass (if applicable)

## 🚀 Ready to Deploy

Once all items are checked:
1. Push code to GitHub
2. Connect repository to Render
3. Apply Blueprint
4. Configure environment variables
5. Monitor deployment logs
6. Test deployed services

---

**Note:** Keep this checklist updated as you prepare for deployment!

