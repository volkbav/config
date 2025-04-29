#!/bin/bash

# Проверяем, что мы в git-репозитории
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # Получаем имя ветки или тега
  branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match)

  # Проверяем наличие незакоммиченных изменений
  dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

  # Проверяем наличие коммитов, ожидающих push
  upstream=$(git rev-list --count --left-only @{u}...HEAD 2>/dev/null)

  # Формируем статус
  status="$branch"
  if [ "$dirty" -gt 0 ]; then
    status+=" ⚡"
  else
    status+=" 🟢"
  fi

  if [ "$upstream" -gt 0 ]; then
    status+=" ⬆"
  fi

  echo "$status"
fi
