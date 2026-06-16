# Employee Portal - Front-End Setup

## Overview

Dark-themed employee portal for Redeemed Enterprises' multi-organization tracking system. Built with vanilla HTML/CSS/JS and Supabase for authentication and data.

## Files

- `login.html` - Login page with email/password authentication
- `dashboard.html` - Dashboard with task overview and stats
- `tasks.html` - Full task management UI with task CRUD, filters, and assignee selection
- `team.html` - Team directory and org chart

## Setup Instructions

### 1. Get Supabase API Keys

1. Go to https://supabase.com/dashboard/project/ftzpjtvyrrnjjcvrtsab
2. Navigate to **Project Settings** → **API**
3. Copy the **`anon` public key** (starts with `eyJ...`)

### 2. Update API Keys in HTML Files

**In `login.html` line 203:**
```javascript
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY'; // Replace with actual key
```

**In `dashboard.html` line 360:**
```javascript
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY'; // Replace with actual key
```

**In `tasks.html`:**
```javascript
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY'; // Replace with actual key
```

Replace `'YOUR_SUPABASE_ANON_KEY'` with the actual `anon` key from step 1.

### 3. Test Admin Login

**Admin credentials (from Supabase deployment):**
- Email: `zmonroe@heinepropane.com`
- User ID: `9b0b95c9-8007-462f-bac8-80abadb5307c`
- Role: `admin`

**You need to set a password for this user:**

1. Go to https://supabase.com/dashboard/project/ftzpjtvyrrnjjcvrtsab/auth/users
2. Find user `zmonroe@heinepropane.com`
3. Click **...** → **Send password recovery**
4. Check email and set a new password

**OR** set password via SQL:

```sql
-- In SQL Editor
UPDATE auth.users
SET encrypted_password = crypt('YOUR_PASSWORD', gen_salt('bf'))
WHERE email = 'zmonroe@heinepropane.com';
```

### 4. Deploy

**Option A: Local Testing**
- Open `login.html` directly in a browser
- Or use a local server: `python3 -m http.server 8000`

**Option B: Static Hosting (Recommended)**
- **Cloudflare Pages:** Connect to a GitHub repo and auto-deploy
- **Netlify:** Drag-and-drop the folder
- **Vercel:** Deploy via CLI or GitHub integration

## Features Implemented

✅ Login with email/password (Supabase Auth)
✅ Dashboard with stats (My Tasks, In Progress, Completed, Overdue)
✅ Recent tasks list with priority indicators
✅ Full task management UI with create, edit, delete, search, and filters
✅ Team directory with organization selector, department cards, search/filter, org chart, and detail modal
✅ Role-based UI (admin sees "Admin" link)
✅ Dark theme (#1A1A1A) with red accent (#E60A00)
✅ Branded red H logo
✅ Responsive design
✅ Logout functionality

## Security Notes

- The `anon` key is **public** and safe to include in client-side code
- Row-Level Security (RLS) policies enforce access control at the database level
- Users can only see tasks assigned to them (unless admin)
- Password authentication is handled by Supabase Auth (bcrypt hashing)

## Next Steps

1. **Team Page** - View team members, departments, org chart
2. **Admin Panel** - User management, organization management
3. **Task Comments** - Add comments to tasks
4. **Real-time Updates** - Supabase Realtime for live task updates
5. **Mobile App** - Consider React Native or PWA

## Troubleshooting

### "Invalid API key" error
- Double-check you copied the **`anon`** key (not the `service_role` key)
- The `anon` key is safe for client-side use

### "User not found" or login fails
- Verify the user exists in **Authentication → Users**
- Make sure `user_profiles` table has a matching entry
- Check that `is_active = true` in the user profile

### Tasks not loading
- Check browser console for errors
- Verify RLS policies allow user to read tasks
- Test queries in SQL Editor:
  ```sql
  SELECT * FROM tasks WHERE assigned_to = '<user_id>';
  ```

### Blank screen after login
- Check browser console for JavaScript errors
- Verify `dashboard.html` has the correct Supabase keys
- Check that localStorage is enabled in your browser

## Design Tokens

**Colors:**
- Background: `#1A1A1A`
- Cards: `#2A2A2A`
- Borders: `#3A3A3A`
- Text: `#E0E0E0`
- Accent (Red H): `#E60A00`

**Fonts:**
- System font stack: `-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif`

**Logo:**
- Red H SVG (viewBox="0 0 315.39 179.63")
- Black outline (#0a0909) + red fill (#e60a00)
