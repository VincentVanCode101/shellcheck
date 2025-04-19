#!/usr/bin/env bash
# install.sh
set -euo pipefail

BINARY_NAME="shellcheck"

_die() {
    echo "Error: $*" >&2
    exit 1
}

_get_repo_dir() {
    REPO_DIR="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"
}

_set_binary() {
    BINARY="${REPO_DIR}/${BINARY_NAME}"
}

_find_target_dir() {
    for dir in "/usr/local/bin" "/opt/homebrew/bin"; do
        if [[ -d "$dir" ]]; then
            TARGET_DIR="$dir"
            return
        fi
    done
    _die "Neither /usr/local/bin nor /opt/homebrew/bin exist. Please create one and add it to your PATH."
}

_set_target() {
    TARGET="${TARGET_DIR}/shellcheck"
}

_create_symlink() {
    echo "Creating symlink: ${TARGET} -> ${BINARY}"
    if [[ -e "$TARGET" || -L "$TARGET" ]]; then
        echo "Removing existing file or symlink at ${TARGET}"
        sudo rm -f "$TARGET"
    fi

    sudo ln -s "$BINARY" "$TARGET"

    local resolved_path
    resolved_path="$(readlink -f "$TARGET")"
    if [[ "$resolved_path" != "$BINARY" ]]; then
        _die "The symlink does not point to the expected file.\nExpected: ${BINARY}\nGot:      ${resolved_path}"
    fi

    echo "Symlink created successfully at ${TARGET}"
}

_main() {
    _get_repo_dir
    _set_binary
    _find_target_dir
    _set_target
    _create_symlink
    echo "install.sh completed successfully."
}

_main "$@"
