-- Run this in Supabase Dashboard > SQL Editor for a new project.
create table if not exists public.workout_rotation (
  user_id uuid primary key references auth.users(id) on delete cascade,
  workouts jsonb not null default '["Upper A + Easy Run","Legs A","Easy Run","Upper B","Legs B","Rest","Long Run"]'::jsonb,
  current_index integer not null default 0,
  completed_count integer not null default 0,
  updated_at timestamptz not null default now()
);

alter table public.workout_rotation enable row level security;

grant select, insert, update on public.workout_rotation to authenticated;

drop policy if exists "Users can read own rotation" on public.workout_rotation;
create policy "Users can read own rotation"
  on public.workout_rotation for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can insert own rotation" on public.workout_rotation;
create policy "Users can insert own rotation"
  on public.workout_rotation for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update own rotation" on public.workout_rotation;
create policy "Users can update own rotation"
  on public.workout_rotation for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
