#!/usr/bin/env bash

# To use this library, put your script in ./scripts and
# add this to the top:
#
#     . "$(dirname "${BASH_SOURCE[0]}")/.prelude.sh"
#
(return 0 2>/dev/null) || cat < "${BASH_SOURCE[0]}"
(return 0 2>/dev/null) || exit 0

# Fun logging commands to brighten our day!
function log_info {
  echo "🌈 info: $1"
}

function log_warning {
  echo "⁉️ warning: $1"
}

function log_error {
  echo "💀 error: $1"
}

# Run this to log an error and exit the program
function die {
  echo "💀 error: $1"
  exit 1
}

# The realpath command in GNU Coreutils - `brew install coreutils` on MacOS
if [ -z "$(command -v realpath || return)" ]; then
  _PRELUDE_SHIMMED_REALPATH="yes"

  # A barely functional shim using Python
  function realpath {
    python3 -c "import os; import sys; print(os.path.realpath(sys.argv[1]))" "$@"
  }
fi

# By convention, this file should live in your project at
# ./scripts/.prelude - $PROJECT_ROOT will reliably be the root
# directory of the project
# shellcheck disable=SC2034
PROJECT_ROOT="$(dirname "$(dirname "$(realpath "${BASH_SOURCE[0]}")")")"

# Call this function to clean up as well as can be expected
function deactivate_prelude {
  unset -f log_info
  unset -f log_warning
  unset -f die

  if [ -n "${_PRELUDE_SHIMMED_REALPATH}" ]; then
    unset -f realpath
  fi
  unset _PRELUDE_SHIMMED_REALPATH

  unset PROJECT_ROOT

  unset -f deactivate_prelude
}
