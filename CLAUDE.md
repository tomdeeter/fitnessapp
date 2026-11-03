# Foundational Fitness Tracker – notes for Claude Code

## What this is
A private, single-file web app (`index.html`: HTML + CSS + JS, no build step) used on a phone.
Data lives in the browser (localStorage cache) and syncs to Supabase table `app_docs` after email/password sign-in.
Hosted on GitHub Pages: **pushing to `main` redeploys the site in about a minute.**

## Rules
- Edit `index.html` only. Keep it a single file with no build tooling.
- Never commit secrets. The Project URL and anon/publishable key near `const SUPABASE_URL` are meant to be public
  (row-level security protects the data). NEVER add a `service_role` / secret key or a database password anywhere.
- Don't change the data shape without keeping old data readable: docs are `p` (settings), `s:<id>` (session), `h:<YYYY-MM>` (old habit data).
- Sync logic is the `Sync` object (+ `showAuth`). It diffs local state against what it last saved and upserts only changed docs. Don't rewrite it casually.
- After any edit, run this syntax check, then commit and push:
  `node -e "const s=require('fs').readFileSync('index.html','utf8');[...s.matchAll(/<script>([\s\S]*?)<\/script>/g)].forEach(x=>new Function(x[1]));console.log('syntax ok')"`
- Commit style: short imperative message, e.g. "Day 4: simplify neck card". Then `git push` to `main`.
- The app is used on a phone (narrow screens, ~360px). Check layouts at that width.

## Layout customizations already made (don't regress these)
- Tabs: Today, Workout, Plan & Videos, History, Progress, Settings. The Habits tab/page was removed on purpose (old habit data is still stored and synced).
- Rest timer defaults: 30 s for Schedule A and B (one-time migration flag `rest30`).
- `LOGV2` = lifting days 2, 4, 7. On those days: half-width lb/reps inputs; no reps placeholder; Set column is a small
  warmup/working dropdown (first two sets default to warmup); no Done checkbox (entering reps completes the set and starts rest);
  no Duration/Effort/Notes card; muscle-slot labels read Compound / Isolated (not Lengthened / Shortened).
- Day 1 (Zone 2 cardio): no Peloton output input, no checkboxes, no Duration/Effort/Notes card.
- Day 2 (Legs): Quadriceps Isolated card above Compound; no Calves Isolated card.
- Day 3 (Cold): only Sauna (min) and Cold (min) inputs; no timer; no description or Duration/Effort/Notes card.
- Day 4 (Torso): Isolated above Compound for Chest and Back; Neck is one card with 4 checkboxes in a 2x2 grid
  (extension, flexion, lateral left, lateral right).
- Day 5 (Moderate cardio): no Peloton output input, no checkboxes, no Duration/Effort/Notes card.
- Day 6 (HIIT): get-ready countdown is 3 s; sprint start = two short high beeps, sprint stop = one long low tone;
  rounds completed logs automatically; no peak-HR input; an R1HR, R2HR… heart-rate box (4 per row) appears per completed sprint;
  duration auto-fills from sprint time + rests; no Effort or Notes inputs (Duration is kept).
- Day 7 (Arms): Biceps, Triceps, Calves (Compound only); no Tibialis card; Neck is the same 4-checkbox 2x2 card as Day 4.
