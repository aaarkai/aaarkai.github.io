# Repository Guidelines

## Project Structure & Module Organization
- Content: `posts/` and `cnposts/` for blog posts, `pages/` for standalone pages.
- Assets: `css/`, `files/`, `favicon.ico`.
- Site generator: `site.hs` (Hakyll rules) and `ChaoDoc.hs` (Pandoc helpers).
- Templates: `templates/` (e.g., `post.html`, `default.html`).
- Output: `_site/` (generated), `_cache/` (build cache). Do not edit these.
- Publishing helpers: `pub.py`, `pub.yaml`, `index_template.html`, `push.sh`.
- Haskell project files: `kaisite.cabal`, `stack.yaml`.

## Build, Test, and Development Commands
- `stack build` — builds the Hakyll executable (`kaisite`).
- `stack exec kaisite clean` — removes generated site output.
- `stack exec kaisite build` — generates the site into `_site/`.
- `stack exec kaisite watch` — rebuilds on change and serves locally (http://127.0.0.1:8000).
- `python pub.py > _site/index.html` — renders the home page from `pub.yaml`.
- `./push.sh` — end‑to‑end publish to `main` (uses git stash/branch switching). Use with care.

Prereqs: Stack (GHC), Python 3 with `requirements.txt`, and a local `katex_cli` binary in repo root (used by `site.hs`).

## Coding Style & Naming Conventions
- Haskell: 2‑space indent; UpperCamelCase modules, lowerCamelCase functions; keep imports explicit.
- Markdown posts: name as `YYYY-MM-DD-title.md`. Include YAML front matter with at least `title:`; `date:` optional (parsed from filename).
- Keep HTML in templates; prefer Markdown + metadata in content files.

## Testing Guidelines
- No formal unit tests. Validate by:
  - `stack exec kaisite build` then open `_site/index.html`.
  - `stack exec kaisite watch` for live preview.
  - Check math rendering (KaTeX) and internal links.

## Commit & Pull Request Guidelines
- Commits: small, descriptive, present‑tense (e.g., `Add cnpost: fluid-dynamics basics`).
- PRs: include summary, before/after screenshots for visual changes, and link related issues. Avoid committing `_site/` except via publish workflow.

## Security & Configuration Tips
- Do not hardcode secrets; this repo is public.
- Ensure `katex_cli` is executable (`chmod +x katex_cli`) and matches platform.
- Do not edit `_site/` directly; regenerate via build steps.
- When using `./push.sh`, confirm you’re on `develop` and review changes before pushing.

