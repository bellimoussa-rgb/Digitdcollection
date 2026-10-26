# Digital data collection tool: deploy folder

Files
- index.html   the website
- config.js    YOUR Supabase URL and key (edit this)
- vercel.json  stops browsers caching old copies after you redeploy
- schema.sql   run once in Supabase (do NOT upload this to Vercel)

Setup
1. Supabase: create a project. SQL Editor > New query > paste the whole of schema.sql > Run.
   If you already ran an older schema.sql, run this one too: the old table is kept and renamed sessions_v1, and a new sessions table is created.
2. Supabase: Project Settings > API. Copy the Project URL and the publishable key (sb_publishable_...) or the anon key.
   Never use the secret or service_role key.
3. Edit config.js: replace YOUR-PROJECT-REF and YOUR-PUBLISHABLE-OR-ANON-KEY.
4. Deploy index.html, config.js and vercel.json to Vercel (GitHub import, or `vercel --prod` in this folder).
5. Open the live address. If a red "Setup needed" bar shows, config.js was not filled in or not deployed.
6. Test: add ?check to the address, press "Run connection test", then delete the TEST row it adds.

What participants do
- Enter a Participant ID, first and last name, choose the session length, set the word range, press Start session.
- Press Submit when finished (it also works after the time is up).
- New session clears the Participant ID (names stay) so one student's ID is not reused by mistake.

What you receive in Supabase, table sessions (all times are Algiers time, Africa/Algiers, UTC+1)
- date                 day the session started
- participant_id       the Participant ID
- students_text        the full text
- starting_time        time the session started
- submission_time      time Submit was pressed
- total_writing_time   start to submission, hh:mm:ss
- word_count           words in the final text
- sentence_count       sentences in the final text
- then technical columns: created_at, session_id, notes_path, report_path, and metrics (JSON with UTC timestamps,
  active typing time, text typed after time, word range, estimated clauses and other measures)
- Storage > reports: one folder per submission with the notes and report Word files (times in the report are Algiers time).
- A repeat submission creates a new row and folder. Use the latest created_at.
- First and last names appear only in the Word files and file names, not in the table.

Troubleshooting: "it does not send"
1. Open your live address followed by ?check and press "Run connection test". It shows which step fails and what to do.
2. After a failed Submit the page shows a red bar with the exact reason. Common ones:
   - "no permission on the table": in the Supabase SQL Editor run
       grant insert on public.sessions to anon, authenticated;
   - "security rule blocked", "bucket does not exist", "table is missing or out of date": run the whole of schema.sql again.
   - "rejected the key": copy the publishable key again into config.js and redeploy.
   - "SECRET key": you pasted the wrong key. Use the publishable (or anon) key.
   - "could not reach Supabase": check the Project URL (https://xxxx.supabase.co, nothing after it), the internet connection, and whether the project is paused.
3. After editing config.js you must redeploy, then force-refresh the page.
