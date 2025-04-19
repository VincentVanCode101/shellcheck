#!/usr/bin/env bash
# uninstall.sh
set -euo pipefail

BINARY_NAME="shellcheck"

_die() {
    echo "Error: $*" >&2
    exit 1
}

_log() {
    echo "$@"
}

_get_repo_dir() {
    REPO_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
}

_set_binary() {
    BINARY="${REPO_DIR}/${BINARY_NAME}"
}

_uninstall_from_directory() {
    local bin_dir="$1"
    local target="${bin_dir}/shellcheck"

    if [[ ! -d "${bin_dir}" ]]; then
        _log "Directory ${bin_dir} does not exist. Skipping."
        return
    fi

    if [[ -L "$target" ]]; then
        local link_target
        link_target="$(readlink -f "$target")"
        if [[ "$link_target" == "$BINARY" ]]; then
            _log "Removing symlink: ${target} -> ${BINARY}"
            sudo rm -f "$target"
        else
            _log "Skipping ${target}, it does not point to the expected binary."
        fi
    elif [[ -e "$target" ]]; then
        _log "A file exists at ${target} but is not a symlink. Skipping removal."
    else
        _log "No file or symlink found at ${target}."
    fi
}

_main() {
    _get_repo_dir
    _set_binary

    local BIN_DIRS=("/usr/local/bin" "/opt/homebrew/bin")
    for bin_dir in "${BIN_DIRS[@]}"; do
        _uninstall_from_directory "$bin_dir"
    done

    _log "uninstall.sh completed successfully."
}

_main "$@"
