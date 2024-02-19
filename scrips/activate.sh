#!/usr/bin/env bash

# Your script should source this file.
(return 0 2>/dev/null) || cat < "${BASH_SOURCE[0]}"
(return 0 2>/dev/null) || exit 0

# Defines $PROJECT_ROOT and a few helper functions
# shellcheck source=scripts/.prelude.sh
. "$(dirname "${BASH_SOURCE[0]}")/.prelude.sh" || return

# Activates the Python virtualenv
# shellcheck source=venv/bin/activate
. "${PROJECT_ROOT}/venv/bin/activate"

log_info "virtualenv path: ${PROJECT_ROOT}/venv"
log_info "python version: $(python --version)!"
log_info "pip version: $(pip --version)"
