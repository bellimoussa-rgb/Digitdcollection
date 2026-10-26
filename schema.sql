-- Run the WHOLE file once in Supabase: SQL Editor > New query > paste > Run.
-- Safe to run again later.

-- 0. If you ran the previous version, keep its rows: the old table is renamed to sessions_v1 (once).
do $$
begin
  if exists (select 1 from information_schema.columns
             where table_schema = 'public' and table_name = 'sessions' and column_name = 'participant_first')
     and not exists (select 1 from information_schema.tables
             where table_schema = 'public' and table_name = 'sessions_v1') then
    alter table public.sessions rename to sessions_v1;
  end if;
end $$;

-- 1. Table. The first columns are the ones you asked for. All times are Algiers time (Africa/Algiers, UTC+1).
create table if not exists public.sessions (
  id                  bigint generated always as identity primary key,
  "date"              date        not null,   -- day the session started, Algiers date
  participant_id      text        not null check (char_length(participant_id) between 1 and 100),
  students_text       text        not null check (char_length(students_text) <= 200000),
  starting_time       time        not null,   -- Algiers time
  submission_time     time        not null,   -- Algiers time
  total_writing_time  interval    not null,   -- from start to submission (hh:mm:ss)
  word_count          int         not null check (word_count >= 0),
  sentence_count      int         not null check (sentence_count >= 0),
  -- technical columns
  created_at          timestamptz not null default now(),
  session_id          text,
  notes_path          text,
  report_path         text,
  metrics             jsonb       -- extra measures: UTC timestamps, active typing time, late text, word range, clauses ...
);
create index if not exists sessions_participant_idx on public.sessions (participant_id, created_at desc);

-- 2. Participants (anonymous visitors) may only ADD rows. They cannot read, change or delete anything.
--    Supabase projects created since May 2026 do not expose new tables to the public key automatically,
--    so the explicit GRANT below is required.
grant usage on schema public to anon, authenticated;
grant insert on public.sessions to anon, authenticated;
alter table public.sessions enable row level security;
drop policy if exists "participants can submit" on public.sessions;
create policy "participants can submit" on public.sessions
  for insert to anon, authenticated with check (true);

-- 3. Private storage bucket for the two Word files (5 MB limit, .docx only)
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('reports', 'reports', false, 5242880,
        array['application/vnd.openxmlformats-officedocument.wordprocessingml.document'])
on conflict (id) do update set public = false, file_size_limit = 5242880,
  allowed_mime_types = array['application/vnd.openxmlformats-officedocument.wordprocessingml.document'];

drop policy if exists "participants can upload" on storage.objects;
create policy "participants can upload" on storage.objects
  for insert to anon, authenticated with check (bucket_id = 'reports');
-- No select policy on purpose: only you (dashboard / service role) can read the files.
