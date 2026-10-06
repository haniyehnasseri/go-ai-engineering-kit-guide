# Repository Risk Priority Scores

Scores in `repo-profile.yaml` are priorities/criticality weights used by Task Intake. They are not probabilities and not standalone bug severities.

- `0`: not applicable / disabled for this repository.
- `1`: very low — lightweight attention only when directly touched.
- `2`: low/moderate — targeted checks when touched.
- `3`: normal production concern — standard checks/review when touched.
- `4`: high — full specialist review/evidence preferred when touched.
- `5`: critical — major workflow driver when touched; skipping expected evidence may cap assurance.

A high score does not make a reviewer run for unrelated changes. Activation uses both the task/change surface and the score.
