# BinaryInk's Pacman Hooks

A set of hooks for pacman to automate tasks on system updates.

- This can be cloned directly to `/etc/pacman.d/hooks`, but be sure to have the
directory and its children owned by root.

## Git Hooks

### Installation

Optional, but recommended: run `.githooks/install-hooks.sh` to ensure any files
added to repo are given correct permissions for pacman to use the hooks. This
does not change ownership. (Alternatively, copy the contents of
.githooks--except `install-githooks.sh`--to `.git/hooks/`).

> **NOTE**
>
> If you'd like to also clear out the *.sample git hooks provided with every
> initialized repository, you can set `CLEAR_SAMPLE_SCRIPTS=1`.
>
> e.g., `CLEAR_SAMPLE_SCRIPTS=1 ./.githooks/install-githooks.sh`

### Provided Git Hooks & Settings

`pre-commit` and `post-merge` git hooks are included to ensure file permissions
remain correct for use within `/etc/pacman.d/hooks`. Run
`.githooks/install-githooks.sh` to automatically copy both git hook scripts to
`.git/hooks/`.
- `pre-commit` is provided to ensure the file permissions when committed to the
  repository are set correctly.
- `post-merge` is provided to ensure the file permissions when pulled or merged
  are set correctly.

The redundancy helps ensure that if the repository is updated with incorrect
permissions that any repository in use in production can be certain their file
permissions are set correctly; however, it should always be the case when adding
hooks and scripts that the file permissions are either manually set correctly or
`pre-commit` is used to provide that guarantee as well.

Seven repository-level settings are provided to override their behavior once
installed:
- **skippachookpermfix**: Prevents changing `*.hook` file permissions to 644 on
  both pre-commit and post-merge.
- **skippachookpermfixprecommit**: Prevents changing `*.hook` file permissions
  to 644 on pre-commit only.
- **skippachookpermfixpostmerge**: Prevents changing `*.hook` file permissions
  to 644 on post-merge only.
- **skippacscriptpermfix**: Prevents changing `*.sh`, `*.ps1`, `*.fish`,
  `*.csh`, and `.py` file permissions to 655 on both pre-commit and post-merge.
- **skippacscriptpermfixprecommit**: Prevents changing `*.sh`, `*.ps1`,
  `*.fish`, `*.csh`, and `.py` file permissions to 655 on pre-commit only.
- **skippacscriptpermfixpostmerge**: Prevents changing `*.sh`, `*.ps1`,
  `*.fish`, `*.csh`, and `.py` file permissions to 655 on post-merge only.
- **skipgithookupdate**: Prevents git hooks from being automatically updated on each pull or merge.

Copied with the `pre-commit` and `post-merge` hooks are the following scripts:
- **set-pachookpermissions.sh**: Sets permissions to 644 for pacman hook files.
- **set-pacscriptpermissions.sh**: Sets permissions to 655 for script files used
  by the hooks.
  
## Pacman Hooks

The following pacman hooks are included in this repository.

### kbuildsycoca6

Used to repopulate 'Open With...' dialog options and default application
settings in Dolphin. While unnecessary when using KDE Plasma due to kservice
handling it, in window managers it may be necessary.

### paccache

Used to clean up old pacman package cache entries to preserve storage space.

### waybar-update-monitor

Used to update a custom waybar module that displays the available number of
packages ready for update.
