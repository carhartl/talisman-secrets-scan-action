#!/bin/sh

set -eu

_user() {
  printf "\033[0;33m%s\033[0m" "$1"
}

_fail() {
  printf "\033[0;31m==> %s\033[0m\n\n" "$1"
}

prep_release() {
  if ! git diff-index --quiet HEAD --; then
    _fail "Repo must not be dirty"
    exit 1
  fi

  grep -rlZE 'v\d+\.\d+\.\d+' --exclude=Dockerfile --exclude-dir=.git . | xargs sed -i '' 's/v[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}/'"$1"'/g'

  _user "Prepare release draft on GitHub? "
  read -r answer
  if [ "$answer" = "y" ]; then
    if ! command -v gh > /dev/null 2>&1; then
      _fail "Script requires GitHub CLI: \`brew install gh\`"
      exit 1
    fi
    git add --update
    git commit -S -m "Prepare for $1 release"
    git push origin main
    git tag -s "$1" -m "Release $1"
    git push --tags
    gh release create --draft --latest --title "$1" --verify-tag
    gh release view "$1" --web
  fi
}

_help() {
  echo "Usage: ./run.sh [command]"
  echo ""
  echo "Available commands:"
  echo "prep-release <version>                Prepare new release draft"
}

cmd="${1:-}"
case "$cmd" in
  "prep-release")
    shift
    prep_release "$@"
    ;;
  *) _help ;;
esac
