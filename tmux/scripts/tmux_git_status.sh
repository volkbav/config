#!/bin/bash

# Находим git репозиторий
dir=$(tmux display-message -p "#{pane_current_path}")
cd "$dir" || exit

if git rev-parse --is-inside-work-tree &>/dev/null; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  dirty=$(git status --porcelain 2>/dev/null)

  if [[ -n "$dirty" ]]; then
    color="colour160"  # Красный
    state="✗"
  else
    git remote update &>/dev/null
    ahead=$(git status -sb 2>/dev/null | grep -o '\[ahead [0-9]\+\]')
    if [[ -n "$ahead" ]]; then
      color="colour220"  # Жёлтый
      state="⇡"
    else
      color="colour34"  # Зелёный
      state="✓"
    fi
  fi

  echo "#[fg=$color] $branch $state"
else
  echo ""
fi

