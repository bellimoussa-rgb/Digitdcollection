# Digital data collection tool: deploy folder

Files
- index.html   the website
- config.js    YOUR Supabase URL and key (edit this)
- vercel.json  stops browsers caching old copies after you redeploy
- schema.sql   run once in Supabase (do NOT upload this to Vercel)

Setup
1. Supabase: create a project. SQL Editor > New query > paste schema.sql > Run.
2. Supabase: Project Settings > API. Copy the Project URL and the publishable key (sb_publishable_...) or the anon key.
   Never use the secret or service_role key.
3. Edit config.js: replace YOUR-PROJECT-REF and YOUR-PUBLISHABLE-OR-ANON-KEY.
4. Deploy index.html, config.js and vercel.json to Vercel (GitHub import, or `vercel --prod` in this folder).
5. Open the live address. If a red "Setup needed" bar shows, config.js was not filled in or not deployed.
6. Test: run a short session and press Submit. Check Supabase: Table Editor > sessions, and Storage > reports.

What participants see
- Start session, then type. Press Submit when finished (it also works after the time is up).
- If the server cannot be reached the page says NOT SUBMITTED and saves an encrypted zip (passcode research001) to the device. Press Submit again when online.
- Save zip copy always saves the encrypted zip locally without sending anything.

What you receive
- Table sessions: names, session length, full text, paragraphs, text typed after time, and measures.
- Storage bucket reports: one folder per submission holding the notes and report Word files.
- A repeat submission by the same participant creates a new row and folder. Use the latest submitted_at.
