# Go Engineering Guidance

This kit intentionally synthesizes several respected Go sources rather than treating any one external style guide as an absolute company architecture.

## Precedence

1. Correctness, safety, explicit task requirements and repository contracts.
2. Established coherent repository/team conventions.
3. Official Go language/tooling guidance.
4. This kit's shared senior-engineering guidance.
5. External style guides as advisory references.

Do not perform broad layout/style churn solely because an external guide prefers a different organization.

## Primary references

- Go Code Review Comments: https://go.dev/wiki/CodeReviewComments
- Go Test Comments: https://go.dev/wiki/TestComments
- Organizing a Go module: https://go.dev/doc/modules/layout
- Package names: https://go.dev/blog/package-names
- Go security best practices: https://go.dev/doc/security/best-practices
- Managing dependencies: https://go.dev/doc/modules/managing-dependencies
- Google Go Style Guide: https://google.github.io/styleguide/go/
- Uber Go Style Guide: https://github.com/uber-go/guide
- spf13/go-skills Go skill: https://github.com/spf13/go-skills/blob/main/go/SKILL.md

The spf13 skill is especially useful for its strong emphasis on clarity over cleverness, small interfaces, contextual errors, explicit goroutine lifetimes, simple Go-native tests, and restraint around generics/abstraction. This kit adopts those durable principles but does **not** blindly adopt repository-layout opinions that conflict with official Go server layout guidance or an existing coherent microservice architecture.

## Shared implementation principles

- clarity > cleverness;
- simplest design that meets current requirements;
- local consistency without preserving known unsafe patterns;
- concrete behavior before abstraction;
- small interfaces at the consumer when useful;
- contextual errors, explicit handling, safe client boundaries;
- contexts/cancellation propagated through request work;
- known goroutine ownership and exit paths;
- explicit resource/data ownership;
- minimal justified dependencies;
- tests as executable behavioral constraints;
- comments/docs for rationale and durable contracts;
- no unrelated "cleanup" during scoped production changes.
