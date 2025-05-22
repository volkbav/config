#!/bin/bash

dir=$(tmux display-message -p "#{pane_current_path}")
cd "$dir" || exit

if git rev-parse --is-inside-work-tree &>/dev/null; then
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  dirty=$(git status --porcelain 2>/dev/null)

  # По умолчанию
  color="colour34"
  state="✓"

  if ! git rev-parse HEAD &>/dev/null; then
    # Нет ни одного коммита
    color="colour160"
    state="⨯"
  elif [[ -n "$dirty" ]]; then
    # Несохранённые изменения
    color="colour160"
    state="✗"
  elif ! git rev-parse --abbrev-ref --symbolic-full-name @{u} &>/dev/null; then
    # Ветка не запушена (нет tracking branch)
    color="colour220"
    state="⧉"
  else
    ahead=$(git rev-list --count @{u}..HEAD)
    if [[ "$ahead" -gt 0 ]]; then
      # Есть незапушенные коммиты
      color="colour220"
      state="⇡"
    else
      # Всё синхронизировано
      color="colour34"
      state="✓"
    fi
  fi

  echo "#[fg=$color] $branch $state"
else
  echo ""
fi
