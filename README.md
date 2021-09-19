# Detect secrets with Talisman action

This action uses [Talisman](https://thoughtworks.github.io/talisman/) to scan the incoming (pushed) range of commits for accidentally added secrets and sensitive information. It mimics a pre-push hook for this, thus it works nicely with a local git hook in tandem, that is as a fallback, last line of defense.

## Example usage

```yml
uses: carhartl/talisman-secrets-scan-action@v1
```
