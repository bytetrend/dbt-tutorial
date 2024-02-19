#!/usr/bin/env bash

# shellcheck source=scripts/.prelude.sh
. "$(dirname "${BASH_SOURCE[0]}")/.prelude.sh"

cd "$PROJECT_ROOT" || die "Couldn't change to project root!"

if [ -z "$CI" ]; then
  . ./scripts/activate.sh
fi

# Uncomment to fail on all errors
# set -e

#
# BEGIN LINTING
#

flake8 || die "❌ Oh no, Flake8 errors!"
shellcheck ./scripts/.prelude.sh ./scripts/* || log_warning "Shellcheck is sad!"

log_info ""
log_info "✅ Looking good!"
