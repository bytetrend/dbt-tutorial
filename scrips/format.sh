#!/usr/bin/env bash

# shellcheck source=scripts/.prelude.sh
. "$(dirname "${BASH_SOURCE[0]}")/.prelude.sh"

cd "$PROJECT_ROOT" || die "Couldn't change to project root!"

. ./scripts/activate.sh

#
# BEGIN AUTO-FORMATTERS
#

black .

log_info ""
log_info "✅ All done!"
