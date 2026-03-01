# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A bilingual (English/Chinese) academic blog and publication portfolio at `aaarkai.github.io`. Built with Hakyll (Haskell static site generator) + Pandoc, with server-side KaTeX math rendering and bibliography support via Citeproc.

## Build & Development Commands

```bash
stack build                          # Build the Hakyll executable (kaisite)
stack exec kaisite clean             # Remove generated output
stack exec kaisite build             # Generate site into _site/
stack exec kaisite watch             # Live rebuild + server at http://127.0.0.1:8000
python pub.py > _site/index.html     # Render home page from pub.yaml
./push.sh                            # Full publish to main branch (use with care)
```

**Prerequisites:** Stack (GHC), Python 3 with `requirements.txt` deps (Jinja2, mistune, BeautifulSoup4, PyYAML), and `katex_cli` binary in repo root (Rust binary from `/Users/kai/dev/katex_cli/target/debug/katex_cli`).

**Validation:** No unit tests. Validate visually via `stack exec kaisite watch`, checking math rendering (KaTeX), internal links, and theorem numbering.

## Architecture

### Build Pipeline

```
Markdown (posts/, cnposts/, pages/)
    → Pandoc (with ChaoDoc extensions: theorem numbering, autoref)
    → Citeproc (bibliography from reference.bib + bib_style.csl)
    → Hakyll templates (templates/)
    → katex_cli (server-side math → HTML)
    → _site/

pub.yaml → pub.py (Jinja2 + mistune) → _site/index.html
```

### Key Source Files

- **`site.hs`** — Hakyll build rules: routing, compilers, contexts, RSS feeds, sitemap. The `chaoDocCompiler` chains Pandoc reading → Citeproc → theorem filter → HTML writing → KaTeX filter.
- **`ChaoDoc.hs`** — Pandoc extensions: theorem environments (Theorem/Definition/Lemma/etc. in EN+CN), auto-numbering, cross-references via `@cite` syntax, and rich title rendering. Exports `chaoDocRead`, `chaoDocWrite`, `theoremFilter`, `chaoDocInline`.
- **`pub.py`** — Renders home page from `pub.yaml` using Jinja2 templates in `index_template.html`. Handles co-author linking, inline math (`$...$`), and venue formatting.

### Bilingual Structure

| | English | Chinese |
|---|---|---|
| Posts | `posts/YYYY-MM-DD-title.md` | `cnposts/YYYY-MM-DD-title-cn.md` |
| Blog index | `blog.html` | `cnblog.html` |
| Template | `templates/default.html` + `post.html` | `templates/cndefault.html` + `cnpost.html` |
| RSS | `/rss.xml` | `/cnrss.xml` |

### CSS Layers

- `default.css` — Base typography, headings, code, responsive widths
- `blog.css` — Blog layout, theorem styling, bibliography, print styles
- `theme.css` — CSS custom properties, serif fonts, 72ch content width, dark mode, first-paragraph indentation
- `homepage.css` — Publication/CV page grid layout

### Git Workflow

- **`develop`** branch: source code (default working branch)
- **`main`** branch: built site for GitHub Pages (only written to by `push.sh`)
- `_site/` and `_cache/` are generated — never edit directly
- `push.sh` stashes changes, builds, rsyncs `_site/` to `main`, pushes, then restores `develop`

## Content Conventions

### Post Front Matter

```yaml
---
title: Post Title (required — supports inline markdown/math)
tags: tag1 tag2
author: kai.wang
---
```

Date is parsed from filename (`YYYY-MM-DD-...`), not from front matter.

### Theorem Environments

Use fenced divs with class names:

```markdown
:::{.Theorem title="Name"}
Statement here.
:::

:::{.Proof}
Proof here.
:::
```

Supported types: Theorem, Conjecture, Definition, Example, Lemma, Problem, Proposition, Corollary (and Chinese equivalents: 定理, 猜想, 定义, 例, 引理, 问题, 命题, 推论). Proof/Remark (证明/备注) are unnumbered.

Cross-reference theorems by their div ID using `@id` cite syntax.

## Coding Style

- **Haskell:** 2-space indent, UpperCamelCase modules, lowerCamelCase functions, explicit imports
- **Posts:** Filename `YYYY-MM-DD-title.md`, YAML front matter with at least `title:`
- **Commits:** Small, descriptive, present-tense (e.g., `Add cnpost: fluid-dynamics basics`)
