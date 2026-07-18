# Lab 00 — Content pipeline

**Honesty tier: Log-only.** The system drafts; a human merges.

## What

An Azure Function (consumption plan) triggered by a GitHub webhook on pushes to
`docs/lab-*/`. It fetches the lab's `README.md` and `NOTES.md` via the GitHub API,
calls the Claude API with a voice + thesis prompt template, and opens a PR against
the hub repo containing two drafts: `hub-post.md` (canonical long-form) and
`linkedin-post.md` (distribution excerpt).

## Why

Every lab should pay twice: once as working code, once as published narrative.
Writing NOTES.md during the build is the only manual step; the pipeline turns it
into publishable drafts. It is also, deliberately, the first deployed component of
the AI OS itself — the safest capability (draft, never publish) bootstraps the system.

## How

1. Webhook (push, `docs/**` filter) → Function HTTP endpoint
2. Function pulls changed lab docs via GitHub API
3. Claude API call with prompt template (`prompts/`, Phase 1)
4. Function opens PR on hub repo via GitHub API — review gate is the merge button

## Status

- [x] Repo conventions + CI guardrail (this commit)
- [x] Infra declared in `infra/main.bicep`
- [ ] Function code (Phase 1)
- [ ] Prompt template (Phase 1)
- [ ] Webhook wired (Phase 1)
