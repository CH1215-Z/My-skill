#!/bin/sh
# wait_release.sh <owner/repo> <tag> [max seconds, default 540] — waits until the GitHub release <tag> has assets
R=${1:?owner/repo}; T=${2:?tag}; MAX=${3:-540}
end=$(( $(date +%s) + MAX ))
while [ "$(date +%s)" -lt $end ]; do
  n=$(gh api "repos/$R/releases/tags/$T" --jq '.assets|length' 2>/dev/null)
  case "$n" in [1-9]*) echo "$T: $n files"; exit 0;; esac
  s=$(gh api "repos/$R/actions/runs?per_page=1" --jq '.workflow_runs[0]|.status+" "+(.conclusion//"")' 2>/dev/null)
  case "$s" in "completed failure"*|"completed cancelled"*) echo "run $s"; exit 1;; esac
  sleep 30
done
echo "no assets after ${MAX}s (last run: $s)"; exit 2
