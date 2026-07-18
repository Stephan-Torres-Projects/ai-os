# AI Operating System (AI OS v2)

A personal AI operating system built in public. Azure AI Foundry as the orchestration
plane, routing tasks by data classification between a **Governed track** (Foundry EU
Data Boundary, self-deployed NIM, tenant-bound M365) and an **Open track** (consumer
seats, hosted NIM), executed through a local runner that keeps credentials on-device.

Editorial thesis: *from pilot to production in regulated Europe.*

## Structure

```
docs/lab-NN-<slug>/   One folder per lab. Each lab = one release + one post + one demo.
  README.md           Technical: what, why, how. Written for a reader.
  NOTES.md            Raw build commentary: decisions, friction, dead ends. Written for the pipeline.
  assets/             Diagrams, screenshots (optional).
infra/                Bicep definitions for all Azure resources. Nothing gets clicked into existence.
```

## Rules (enforced by CI)

- Every `docs/lab-*` folder must contain a non-empty `README.md` and `NOTES.md`.
- PRs touching `docs/` that fail this check cannot merge.
- All Azure infra is declared in `infra/` — portal-created resources don't exist.

## Honesty tiers

| Tier | Meaning |
|------|---------|
| Automate | System acts without review |
| Launch-with-context | System acts, human informed with rationale |
| Log-only | System drafts/records, human decides |

The content pipeline (Lab 00) runs at **Log-only**: it opens PRs, never publishes.
