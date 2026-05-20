# deb-overmind

This repository is dedicated to building and releasing Debian packages (`.deb`) for [Overmind](https://github.com/DarthSim/overmind).

## What is Overmind?

**Overmind** is a process manager for Procfile-based applications and tmux. It is designed to run several processes specified in a `Procfile` in a single terminal session, allowing you to manage them easily, see their output in one place, and interact with them using `tmux`.

Key features include:
- **tmux integration**: Each process runs in its own tmux window.
- **Process management**: Easily start, stop, and restart individual processes.
- **Environment support**: Load environment variables from `.env` files.
- **Socket communication**: Control Overmind via a Unix socket.

## Repository Purpose

This repository automates the process of:
1.  **Monitoring**: Checking for new releases from the upstream [DarthSim/overmind](https://github.com/DarthSim/overmind) repository.
2.  **Building**: Downloading the latest binaries and packaging them into `.deb` files for multiple architectures (`amd64`, `arm64`).
3.  **Releasing**: Publishing these packages as GitHub Releases in this repository.

## How it Works

- **`.github/workflows/check-upstream.yml`**: A scheduled action that runs daily to check if a new version of Overmind has been released. If a new version is found, it triggers the build workflow.
- **`.github/workflows/build-binary.yml`**: Performs the actual packaging. It uses `scripts/package_binary.sh` to create the Debian package structure and then uploads the results to a new release.
- **`package.env`**: Contains configuration metadata used by the build scripts, such as the upstream repository name and package description.
