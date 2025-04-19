# Dockerized ShellCheck

A simple Docker-based wrapper for [ShellCheck](https://www.shellcheck.net/) to lint your shell scripts without installing it locally.

## Requirements

- **Docker** must be installed and running
- **macOS** or **Linux**  
  ❌ **Windows is not supported**

## Usage

To run ShellCheck on all scripts in the current directory (recursively):

```bash
./shellcheck
```

To check specific files:

```bash
./shellcheck your-script.sh
```

## Installation

To install the wrapper globally (creates a symlink in `/usr/local/bin` or `/opt/homebrew/bin`):

```bash
./install.sh
```

To uninstall:

```bash
./uninstall.sh
```

---