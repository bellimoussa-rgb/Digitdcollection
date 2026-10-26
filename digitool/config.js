/* Fill these in from Supabase: Project Settings > API (Project URL) and API Keys (publishable / anon key).
   The key is meant to be public. Security comes from the database rules in schema.sql. Never put the secret or service_role key here. */
window.DCT_CONFIG={
  url:"https://YOUR-PROJECT-REF.supabase.co",
  key:"YOUR-PUBLISHABLE-OR-ANON-KEY",
  bucket:"reports",
  localCopy:false   /* true = participants also download the encrypted zip after submitting */
};
