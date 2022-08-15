# Detect secrets with Talisman action

This action uses [Talisman](https://thoughtworks.github.io/talisman/) to scan the incoming (pushed) range of commits for accidentally added secrets and sensitive information. It mimics a pre-push hook for this, thus it works nicely with a local git hook in tandem, that is as a fallback, last line of defense.

## Example usage

```yml
steps:
  - name: Detect secrets with Talisman in incoming commits
    uses: carhartl/talisman-secrets-scan-action@v1.3.0
```

## Caveat

When using this along with the `actions/checkout@v2` step you'll need to configure it to avoid a too shallow clone:

```yml
- uses: actions/checkout@v2
  with:
    fetch-depth: 0
```

Otherwise you may run into Talisman erroring out while it's trying to execute git with an invalid revision range:

```
time="2021-09-19T07:07:32Z" level=fatal msg="Git command execution failed" command="git diff 0c4a631e70056a95df1c235d238a80828e07cf9c..a32a5c7e1a3d250bf18a080a44a764d9b93b9690 --name-only --diff-filter=ACM" dir=/github/workspace error="exit status 128" output="fatal: Invalid revision range 0c4a631e70056a95df1c235d238a80828e07cf9c..a32a5c7e1a3d250bf18a080a44a764d9b93b9690\n"
```
