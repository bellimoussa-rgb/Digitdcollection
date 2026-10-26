/* STEP 1: replace the two values below with yours from Supabase.
   Supabase dashboard > Project Settings > API: copy "Project URL" and the "publishable" key (or the older "anon" key).
   The key is meant to be public. NEVER paste the secret or service_role key here.
   STEP 2: save this file and redeploy. The red "Setup needed" bar disappears when this is filled in correctly. */
window.DCT_CONFIG={
  url:"https://YOUR-PROJECT-REF.supabase.co",
  key:"YOUR-PUBLISHABLE-OR-ANON-KEY",
  bucket:"reports",
  localCopy:false   /* true = participants also get an encrypted zip copy after submitting */
};
