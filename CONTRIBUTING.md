# Contributing

## Setup

```
git clone https://github.com/georges-ph/pantry.git
cd pantry
dart pub get
```

## Before submitting a change

```
dart format .
dart analyze
```

If your change touches a request, try it against a real pantry with the example (get a free pantry ID at [getpantry.cloud](https://getpantry.cloud)):

```
dart run example/main.dart <your-pantry-id>
```

Pantry rate-limits quick calls, so leave a few seconds between requests when testing by hand.

## Submitting

- Open a PR against `main` with a short description of what changed and why.
- Add a `CHANGELOG.md` entry under an `[Unreleased]` heading if the change is user-facing.
- Keep PRs focused — one change per PR is easier to review.
