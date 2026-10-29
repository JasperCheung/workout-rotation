# Workout Rotation — iPhone install + cloud sync

## What this is
A small installable web app (PWA). It can be added to the iPhone Home Screen from Safari. It is not an App Store-native app. Progress saves locally by default; Supabase enables account-based sync between devices.

## 1. Put the app online
PWA installation needs HTTPS. One easy option is GitHub Pages:
1. Create a GitHub repository (for example `workout-rotation`).
2. Upload `index.html`, `manifest.webmanifest`, `service-worker.js`, `icon-192.png`, and `icon-512.png` to the repository root.
3. In the repository, open **Settings → Pages** and deploy from the `main` branch and `/ (root)`.
4. Wait for the Pages URL to appear. Open that URL in Safari on your iPhone.

## 2. Install on iPhone
1. Open the published site in **Safari**.
2. Tap **Share**.
3. Choose **Add to Home Screen**. If offered, enable **Open as Web App**.
4. Tap **Add**.

## 3. Set up cloud sync (optional but recommended)
1. Create a project at https://supabase.com/dashboard
2. In **SQL Editor**, run the full contents of `supabase-setup.sql`.
3. In **Authentication → URL Configuration**, add your deployed site URL to the allowed redirect URLs. If using GitHub Pages, add the full Pages URL.
4. In **Project Settings → API**, copy the Project URL and the **publishable key** (or legacy anon key).
5. Open the app, tap **Cloud sync**, paste the URL and public key, enter your email, and tap **Connect / send sign-in link**.
6. Open the email sign-in link. Sign in on each device with the same email and use the same deployed app URL.

The app saves locally even if cloud sync is not configured. Once signed in, the cloud copy is used when the app loads and changes sync after tapping Done or editing the rotation.

### Security
- The project URL and publishable/anon key are designed to be used in client apps. Row Level Security (RLS) in the supplied SQL limits each signed-in user to their own row.
- **Never put a Supabase `service_role` or secret key into this app or share it.**
- In Supabase Auth URL settings, configure your actual deployed URL. If magic-link login returns to the wrong place, update the allowed redirect URLs.
- Keep a copy of your rotation data before making major changes.

## Current behavior / limitations
- The default rotation is Upper A + Easy Run → Legs A → Easy Run → Upper B → Legs B → Rest → Long Run.
- Done advances one step and increments the completion count. Undo moves back one step and decrements the count (not a full historical undo log).
- The app is intentionally minimal. It does not send reminders or track workout details.
- A native App Store app would require a separate native build and Apple’s distribution process.
