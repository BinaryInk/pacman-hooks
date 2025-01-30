#!/bin/sh
#
# Installs all provided git hooks and scripts in .githooks (except this script)

SCRIPTROOT="$(git rev-parse --show-toplevel)/.githooks"

cd $SCRIPTROOT/..

GITHOOKSPATH="$(git rev-parse --show-toplevel)/.git/hooks"

echo "Installing git hooks..."
for file in ${SCRIPTROOT}/*; do
    if [ -f "$file" ]; then
        case "$(basename "$file")" in
            install.githooks.sh)
                # Skip this file
                ;;
            applypatch-msg|\
            commit-msg|\
            fsmonitor-watchman|\
            post-update|\
            pre-applypatch|\
            pre-commit|\
            pre-merge-commit|\
            pre-push|\
            pre-rebase|\
            pre-receive|\
            prepare-commit-msg|\
            update|\
            post-merge|\
            post-checkout|\
            post-commit|\
            post-rewrite|\
            pre-auto-gc|\
            post-index-change|\
            push-to-checkout|\
            set-pachookpermissions.sh|\
            set-pacscriptpermissions.sh)
                dest="${GITHOOKSPATH}/$(basename "$file")"

                cp -fv "$file" "$dest" || echo "Failed to copy '$dest' to $file" 1>&2 
                chmod +x "$dest" || echo "Failed to make '$dest' executable" 1>&2
                ;;
        esac
    fi
done

if [[ $CLEAR_SAMPLE_SCRIPTS ]]; then
    echo "Clearing sample scripts from '.git/hooks'..."
    for file in $GITHOOKSPATH/*.sample; do
        if [ -f "$file" ]; then rm -fv "$file"; fi
    done
fi
