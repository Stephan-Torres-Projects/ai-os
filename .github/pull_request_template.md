# PR checklist

## What

<!-- One paragraph: what this PR does. -->

## Lab documentation (required if this PR touches docs/ or adds a lab)

- [ ] `docs/lab-NN-<slug>/README.md` exists and is written for a reader (what/why/how)
- [ ] `docs/lab-NN-<slug>/NOTES.md` exists and contains raw commentary (decisions, friction, dead ends)
- [ ] Any new Azure resource is declared in `infra/` (Bicep), not created in the portal

## Honesty tier

- [ ] If this PR adds automation, its tier is stated in the lab README: `Automate` / `Launch-with-context` / `Log-only`
