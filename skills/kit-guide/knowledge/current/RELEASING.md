# Releasing

`VERSION` is the source of truth. Use Semantic Versioning.

- patch: compatible fixes/docs/safety corrections;
- minor: backward-compatible capabilities/skills/profile fields;
- major: incompatible schema/workflow/installer/assurance semantics.

## Prepare

Update `VERSION` and `CHANGELOG.md`, then run:

```bash
make validate
make test
./scripts/check-release.sh --allow-dirty-ci   # before the release commit if needed
```

Commit the release changes. With a clean working tree:

```bash
make release-check
./scripts/tag-release.sh
```

`tag-release.sh` creates an annotated `vX.Y.Z` tag and never pushes automatically.

Push explicitly when reviewed:

```bash
git push origin <branch>
git push origin vX.Y.Z
```

## Package

After the release commit/tag is at HEAD:

```bash
make package
```

Packaging uses `git archive`, so release artifacts come from the committed tree rather than arbitrary uncommitted local files. Artifacts are written to `dist/` with a SHA-256 checksum.
