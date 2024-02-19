#!/usr/bin/env bash

# shellcheck source=scripts/.prelude.sh
. "$(dirname "${BASH_SOURCE[0]}")/.prelude.sh"

log_info "Hold tight and I'll set you up 💪"

cd "$PROJECT_ROOT" || die "Couldn't change to project root!"

if [ ! -d "${PROJECT_ROOT}/venv" ]; then
  log_info "No virtualenv detected!"
  log_info "Creating a fresh virtualenv at ${PROJECT_ROOT}/venv using ($(command -v python3))..."

  python3 -m venv "${PROJECT_ROOT}/venv" || die "Problem creating virtualenv!"
fi

. ./scripts/activate.sh

log_info "Upgrading pip..."
pip install --upgrade pip || log_warning "Issues while upgrading pip! Trucking along..."

log_info "Installing development dependencies..."
pip install -r requirements_dev.txt || die "Issues while installing dependencies!"

log_info "Your DAG's development environment is set up and ready to go!"
