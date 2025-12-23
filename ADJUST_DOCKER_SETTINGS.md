# 🔧 Adjust Docker Desktop Settings - Step by Step

## Your System Resources
- **Total RAM**: 16 GB ✅ (Plenty available)
- **CPU Cores**: 8 ✅ (Plenty available)
- **Disk Space**: 87 GB available ✅

## Recommended Docker Desktop Settings
- **Memory**: **8 GB** (you can afford this with 16GB total)
- **CPUs**: **4 cores**
- **Disk**: 20GB+ (you have 87GB available)

## Step-by-Step Instructions

### Step 1: Open Docker Desktop Settings
1. Open **Docker Desktop** application
2. Look for the **Settings** icon (gear/cog icon) in the top right
3. Click it

### Step 2: Go to Resources
1. In the left sidebar, click **"Resources"**
2. Then click **"Advanced"** tab

### Step 3: Adjust Memory
1. Find the **"Memory"** slider
2. **Drag it to 8 GB** (or at least 4 GB minimum)
3. You'll see the value update as you drag

### Step 4: Adjust CPUs
1. Find the **"CPUs"** setting
2. **Set it to 4** (or use the slider/dropdown)
3. Make sure it's at least 4

### Step 5: Apply Changes
1. Click **"Apply & Restart"** button (usually at bottom right)
2. Docker Desktop will restart
3. **Wait 30-60 seconds** for it to fully restart
4. Wait until you see **"Engine running"** at the bottom

### Step 6: Verify Settings
1. After restart, go back to **Settings → Resources → Advanced**
2. Verify:
   - Memory shows **8 GB** (or at least 4 GB)
   - CPUs shows **4**
3. Close settings

### Step 7: Run Setup
1. **Open a NEW Terminal window** (important!)
2. Run:
   ```bash
   cd /Users/OceanCyber/Downloads/myexrow
   ./robust-setup.sh
   ```

## Visual Guide

```
Docker Desktop
├── Settings (gear icon) → Click here
    └── Resources → Click here
        └── Advanced → Click here
            ├── Memory: [Slider] → Drag to 8 GB
            ├── CPUs: [Input] → Set to 4
            └── Apply & Restart → Click here
```

## Why These Settings?

- **8 GB Memory**: Prevents Docker daemon crashes during builds
- **4 CPUs**: Speeds up image builds significantly
- **With 16 GB total RAM**: You have plenty to spare

## After Adjusting

Once Docker Desktop restarts with new settings:
- ✅ Docker daemon will be more stable
- ✅ Builds will be faster
- ✅ Connection issues should be resolved

Then run the setup script in a NEW terminal window.

---

**Most Important: Set Memory to at least 4GB (8GB recommended with your 16GB system)**

