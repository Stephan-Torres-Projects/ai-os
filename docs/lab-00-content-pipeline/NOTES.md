# Lab 00 — Build notes (raw)

<!-- Write here WHILE building, not after. Decisions, friction, dead ends.
     This file is the pipeline's raw material — your voice, not polished prose. -->

## 2026-07-18 — Session 1

- Decided Azure Function over GitHub Actions for generation. Not for simplicity —
  the opposite. The pipeline should BE a component of the AI OS (Governed track,
  Log-only tier), not tooling next to it. A GitHub Action is a script; a Function
  in the same resource group as the future NIM VM is architecture.
- PR-based review gate chosen over auto-commit. Log-only tier means the system
  never publishes; it proposes.
- Guardrails: GitHub branch protection + CI structure check instead of Azure DevOps
  policies. Same instinct (enforce the convention, don't suggest it), native mechanism.
- Two repos, not one: ai-os is the engineering artifact, hub is the publishing
  surface. A hub redesign must never touch lab conventions.
- Parked: thesis re-sharpening ("pilot to production" umbrella kept, mechanism-level
  angles per post). Parked: hub visual design until real content exists to test against.

## TODO next session

- Function code + prompt template
- Webhook secret handling → Key Vault, not app settings
