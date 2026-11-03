# Foundational Fitness Tracker (private)

## One-time setup

### 1. Supabase (database + login)
1. Supabase dashboard > your project > **SQL Editor** > New query. Paste `supabase_setup.sql` and click **Run**.
2. **Authentication > Users > Add user > Create new user.** Enter your email and a password, and tick **Auto Confirm User**.
3. **Authentication > Sign In / Providers (or Settings)** > turn **off** "Allow new users to sign up". Only the user you created can sign in.
4. **Project Settings > API Keys** (or "API"). Copy the **Project URL** and the **anon / publishable** key.
   Do NOT use the `service_role` / secret key, and never paste it anywhere.

### 2. Put the keys in the app
Open `index.html`, find these two lines near the top of the script, and replace the placeholders with your values:
```
const SUPABASE_URL='https://YOUR-PROJECT-REF.supabase.co';
const SUPABASE_ANON_KEY='YOUR-ANON-OR-PUBLISHABLE-KEY';
```

### 3. GitHub Pages (hosting)
1. Create a new GitHub repo (for example `fitness-tracker`) and add `index.html`, `CLAUDE.md`, `README.md`, `supabase_setup.sql`.
2. Repo **Settings > Pages** > Source: **Deploy from a branch** > Branch: `main`, folder `/ (root)` > Save.
3. After about a minute your app is at `https://<your-username>.github.io/<repo>/`.
4. On your phone, open that URL, sign in, then use **Share > Add to Home Screen** (iPhone) or **Install app / Add to Home screen** (Android).

### 4. Move your existing data
In the old Claude version: Settings > **Export backup (.json)**. In the new app: sign in, then Settings > **Import backup**. It uploads to your database, and every device you sign in on will see it.

## Updating later
Use Claude Code in a clone of the repo (see CLAUDE.md). Describe the change, let it edit `index.html`, check it, commit and push. The site updates in about a minute; reload the page (or reopen the home-screen app) to get it.
