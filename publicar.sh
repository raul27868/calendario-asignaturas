#!/usr/bin/env bash
set -eu

git status

printf '\n¿Desea continuar? [s/N] '
if ! IFS= read -r answer; then
  printf '\nNo se recibió confirmación. Finalizando.\n'
  exit 0
fi

case "$answer" in
  s|S|si|Si|SI|sí|Sí|SÍ) ;;
  *)
    printf 'Operación cancelada.\n'
    exit 0
    ;;
esac

branch=$(git branch --show-current)
if [ "$branch" != "main" ]; then
  printf 'La rama actual es "%s"; GitHub Pages está configurado para publicar "main". No se realizaron cambios.\n' "$branch" >&2
  exit 1
fi

git add .

if git diff --cached --quiet; then
  printf 'No hay cambios para confirmar.\n'
  exit 0
fi

printf 'Texto del commit: '
if ! IFS= read -r commit_message || [ -z "$commit_message" ]; then
  printf 'El mensaje del commit no puede estar vacío. Los cambios siguen preparados para commit.\n' >&2
  exit 1
fi

git commit -m "$commit_message" \
  -m "Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>"
git push

printf '\nPush completado. GitHub Pages desplegará los cambios desde main automáticamente.\n'
