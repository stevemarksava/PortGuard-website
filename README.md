# PortGuard — Demo & Architecture Blueprint

> Federated, contract-driven access for the Port of Rotterdam ecosystem.
> Built on **InnoTractor** connectors, **Digidentity** policies, and **Avanade** Data & AI.

An interactive presentation surface that replaces PowerPoint — three modes (Promo / Quick / Full demo), full EN/NL toggle, embedded demo videos, and an architecture explorer.

🌐 **Live demo:** _replace this with your GitHub Pages URL after deploy_

---

## What's in here

```
.
├── index.html            ← the entire app (single file, self-contained)
├── videos/               ← three demo clips (~190 MB total)
│   ├── PortGuardDemo-1_1.mp4
│   ├── PortGuardDemo-1_2.mp4
│   └── PortGuardDemo-1_3.mp4
├── .github/workflows/
│   └── pages.yml         ← auto-deploys to GitHub Pages on push to main
├── .gitattributes        ← Git LFS config for the video files
├── .gitignore
└── README.md
```

The app is a single HTML file using React + Tailwind via CDN. No build step. No `node_modules`. No package.json needed.

---

## Quick start (local)

```bash
git clone https://github.com/YOUR-USERNAME/portguard-demo.git
cd portguard-demo

# any static server works — pick one
npx serve .
# or
python3 -m http.server 8000
```

Open `http://localhost:8000` (or whatever port your server prints).

> Opening `index.html` directly via `file://` works for everything **except the videos** — browsers block file:// video playback for security. Always use a local server.

---

## Deploy to GitHub Pages

### Option A — automated (recommended)

A workflow file is included at `.github/workflows/pages.yml`. On every push to `main` it builds and publishes to Pages.

1. **Create the repo on GitHub** (UI or `gh repo create`)
2. **Enable Pages with GitHub Actions as the source:**
   `Settings → Pages → Build and deployment → Source: GitHub Actions`
3. **Push:**
   ```bash
   git init
   git add .
   git commit -m "initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR-USERNAME/portguard-demo.git
   git push -u origin main
   ```
4. The Actions tab will show the deploy running. Once green, your site is live at
   `https://YOUR-USERNAME.github.io/portguard-demo/`

### Option B — branch-based (classic)

`Settings → Pages → Source: Deploy from a branch → main → / (root)`.
GitHub will serve `index.html` directly. Slower (no Action), but no workflow file needed.

---

## About the videos — read this

The three demo MP4s total **~190 MB**. That's under GitHub's hard limits but you have three sensible options.

### Option 1 — Git LFS (default, set up for you)

`.gitattributes` is configured so videos are tracked by Git LFS. Install it once on your machine:

```bash
git lfs install
```

Then push as normal. Files won't count against the repo's flat 1 GB limit, and the videos will stream from LFS instead of being baked into git history.

> **LFS bandwidth:** the free tier gives 1 GB/month bandwidth and 1 GB storage. For a private demo that's plenty. For a public viral page, see Option 3.

### Option 2 — Plain commit (skip LFS)

If you don't want LFS, delete `.gitattributes` before the first commit. Files commit normally. Works fine, but grows the repo permanently.

```bash
rm .gitattributes
```

### Option 3 — Host videos elsewhere (recommended for shareable links)

Upload each video to YouTube (unlisted) or Vimeo, then replace the `<video>` tags with `<iframe>`. Faster page load, no LFS, no bandwidth concerns.

In `index.html`, find this array near the top of the JSX:

```js
const VIDEOS = [
  { id: 1, src: 'videos/PortGuardDemo-1_1.mp4', tag: 'DEMO 01', personaId: 'port' },
  ...
];
```

Either change the `src` to a CDN URL, or swap the `<video>` element in `DemoSection` for a YouTube iframe.

---

## Editing the content

Everything is in `index.html`. Key sections to look for:

| Want to change… | Find this constant |
|---|---|
| Translations (EN / NL) | `const I18N = { en: {...}, nl: {...} }` |
| Personas (icon, name, code, endpoint) | `const PERSONAS = [...]` |
| Five key capabilities | `const CAPABILITIES = [...]` |
| Architecture layers | `const ARCHITECTURE = [...]` |
| AI Tool Access matrix | `const AI_MATRIX = [...]` |
| Video sources / order | `const VIDEOS = [...]` |
| Brand colors | the `:root { --port: ... }` block at the top of `<style>` |

To add a third language, copy the `en:` block, translate, and add the language code to the EN/NL toggle in `App()` and the header.

---

## Three presentation modes

- **⚡ Promo (~2 min)** — five key capabilities + one demo video + the three "truths" + value scenarios. For executives.
- **⏱ Quick demo (~5 min)** — capabilities, demo, three truths, architecture, AI agnostic. For technical leads.
- **📺 Full demo (~15 min)** — every section. For deep-dive workshops.

A mode picker appears first; users can switch modes any time from the header.

---

## Tech (such as it is)

- **React 18** via CDN, no build
- **Babel standalone** for in-browser JSX
- **Tailwind** via CDN (`cdn.tailwindcss.com`)
- Fonts: Inter, JetBrains Mono via Google Fonts

The whole thing is a single 100 KB HTML file. It will render correctly even when opened from a USB stick (minus the videos — see above).

---

## License & attribution

This demo represents architecture work for **DronePort Rotterdam**.
**Partners:** InnoTractor (connectors) · Digidentity (identity & policy) · Avanade (Data & AI).

_Access governed by Digidentity policies via InnoTractor connectors. Data & AI by Avanade._
