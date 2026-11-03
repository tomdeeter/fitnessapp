-- Run this once in Supabase: SQL Editor > New query > paste > Run.
-- One table holds all app data as small JSON documents, one row per document:
--   key 'p'          = settings
--   key 's:<id>'     = one workout session
--   key 'h:<YYYY-MM>'= one month of habit check-offs (kept for old data)

create table if not exists public.app_docs (
  user_id    uuid not null default auth.uid() references auth.users (id) on delete cascade,
  key        text not null,
  data       jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

-- Row-level security: each signed-in user can only touch their own rows.
alter table public.app_docs enable row level security;

drop policy if exists "own rows: select" on public.app_docs;
drop policy if exists "own rows: insert" on public.app_docs;
drop policy if exists "own rows: update" on public.app_docs;
drop policy if exists "own rows: delete" on public.app_docs;

create policy "own rows: select" on public.app_docs for select to authenticated
  using ((select auth.uid()) = user_id);
create policy "own rows: insert" on public.app_docs for insert to authenticated
  with check ((select auth.uid()) = user_id);
create policy "own rows: update" on public.app_docs for update to authenticated
  using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "own rows: delete" on public.app_docs for delete to authenticated
  using ((select auth.uid()) = user_id);
