# 🚀 Deploy Employee Portal to Cloudflare Pages

## Quick Deployment Steps

### 1. Create GitHub Repository

**Via GitHub Web Interface:**
1. Go to https://github.com/new
2. Repository name: `employee-portal`
3. Description: `Multi-org employee tracking portal`
4. Set to **Private** (contains API keys)
5. Click **Create repository**

**OR via GitHub Desktop:**
1. Open GitHub Desktop
2. File → Add Local Repository
3. Choose: `/mnt/c/Users/zaker/Desktop/employee-portal`
4. Click "Publish repository"
5. Make sure **Private** is checked
6. Click "Publish"

---

### 2. Push the Code

**If you created via web interface, run these commands in PowerShell:**

```powershell
cd C:\Users\zaker\Desktop\employee-portal
git remote add origin https://github.com/zmonroe101/employee-portal.git
git push -u origin master
```

**If you used GitHub Desktop, it's already pushed!** ✅

---

### 3. Deploy to Cloudflare Pages

1. **Go to Cloudflare Pages:**  
   https://dash.cloudflare.com/pages

2. **Click "Create a project"**

3. **Connect to Git:**
   - Select **GitHub**
   - Authorize Cloudflare if needed
   - Select repository: **`employee-portal`**

4. **Configure build settings:**
   - **Project name:** `employee-portal` (or `heine-employee-portal`)
   - **Production branch:** `master`
   - **Build command:** *(leave empty)*
   - **Build output directory:** `/`
   - Click **Save and Deploy**

5. **Wait ~1-2 minutes for deployment**

6. **Your portal will be live at:**  
   `https://employee-portal.pages.dev`  
   *(or whatever custom domain you set)*

---

### 4. Test Login

Once deployed, visit:
- `https://employee-portal.pages.dev/login.html`

**Login with:**
- Email: `zmonroe@heinepropane.com`
- Password: *(Your Supabase admin password)*

The DNS issue won't affect the deployed site! ✅

---

## Custom Domain (Optional)

If you want `portal.heinepropane.com`:

1. In Cloudflare Pages project settings
2. Go to **Custom domains**
3. Add domain: `portal.heinepropane.com`
4. Update DNS as instructed by Cloudflare

---

## Files Committed & Ready:

✅ `login.html` - Full API key, error handling  
✅ `dashboard.html` - Org switcher, profile management  
✅ `tasks.html` - Task CRUD with filters (46KB)  
✅ `team.html` - Employee directory (59KB)  
✅ `README.md` - Setup documentation  

**All files have the working Supabase anon key!**

---

## Security Note

The Supabase **anon (public) key** is safe to expose in client-side code - it's designed for this. Row-Level Security (RLS) policies on Supabase protect your data, not the anon key.

**However**, if you prefer extra caution, you can:
1. Make the GitHub repo **Private** ✅ (recommended, already done)
2. Use Cloudflare Access to add auth in front of the portal

---

## Rollback Instructions

If something breaks after deployment:

**Via Cloudflare Dashboard:**
1. Go to your employee-portal project
2. Click **Deployments** tab
3. Find the previous working deployment
4. Click **⋯** → **Rollback to this deployment**

**Via Git:**
```bash
cd /mnt/c/Users/zaker/Desktop/employee-portal
git revert HEAD
git push origin master
```
Cloudflare auto-deploys the revert in ~1 minute.

---

## What Happens Next

1. **Push to GitHub** (manual step needed)
2. **Connect to Cloudflare Pages** (one-time setup, ~3 minutes)
3. **Auto-deploy on every push** (future updates instant!)

Once deployed, the live site will bypass your local DNS issue and you can test login immediately! 🎯

---

**Ready to deploy? Start with Step 1!**
