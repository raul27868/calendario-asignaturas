# Cheatsheet de desarrollo y despliegue
## Proyecto `calendario-asignaturas`

Esta chuleta resume los comandos y configuraciones más útiles para trabajar con el proyecto desde **GitHub Codespaces**, probar cambios antes de publicarlos y mantener actualizado **GitHub Pages**.

---

## 1. Flujo de trabajo recomendado

```text
Editar en Codespaces / Codex
        ↓
Probar en Codespaces
        ↓
git status
git diff
        ↓
git add
git commit
        ↓
git pull --rebase origin main
        ↓
git push origin main
        ↓
GitHub Pages despliega automáticamente
```

Regla práctica:

> Probar primero. Commit después. Push solo cuando el cambio esté validado.

---

## 2. Estado del repositorio

Ver archivos modificados:

```bash
git status
```

Ver diferencias todavía no añadidas al commit:

```bash
git diff
```

Ver diferencias ya añadidas con `git add`:

```bash
git diff --cached
```

Ver rama actual:

```bash
git branch --show-current
```

Normalmente debe ser:

```text
main
```

---

## 3. Historial

Últimos commits:

```bash
git log --oneline -10
```

Historial gráfico con ramas locales y remotas:

```bash
git log --oneline --decorate --graph --all -12
```

Último commit local:

```bash
git log -1 --oneline
```

Último commit conocido de `origin/main`:

```bash
git log origin/main -1 --oneline
```

---

## 4. `main` frente a `origin/main`

- `main`: rama local del Codespace.
- `origin/main`: última versión conocida de la rama `main` en GitHub.

Actualizar la información del remoto sin modificar archivos:

```bash
git fetch origin
```

Ver commits locales todavía no publicados:

```bash
git log origin/main..HEAD --oneline
```

Si aparecen commits, existen en el Codespace pero todavía no están en GitHub.

Ver commits que están en GitHub pero todavía no están en local:

```bash
git log HEAD..origin/main --oneline
```

Comparar local con remoto:

```bash
git diff origin/main..HEAD
```

Ver solo los archivos distintos:

```bash
git diff --name-status origin/main..HEAD
```

---

## 5. Preparar un commit

Si solo se ha modificado `index.html`:

```bash
git add index.html
```

Si se quiere añadir todo lo modificado:

```bash
git add .
```

Revisar lo que entrará en el commit:

```bash
git diff --cached
```

Crear el commit:

```bash
git commit -m "Descripción breve del cambio"
```

Ejemplos:

```bash
git commit -m "Añadir comentarios por asignatura"
git commit -m "Ajustar impresión a A4 vertical"
git commit -m "Mejorar carga y descarga del calendario"
```

---

## 6. Antes de hacer `push`

Sincronizar primero con GitHub:

```bash
git pull --rebase origin main
```

Si termina sin conflictos:

```bash
git push origin main
```

`--rebase` coloca tus commits locales después de los commits remotos y evita un merge innecesario.

---

## 7. ¿Qué hace `git push origin main`?

```text
push    → envía commits locales
origin  → repositorio remoto de GitHub
main    → rama que se actualiza
```

En este proyecto:

```text
Codespace
   ↓ git push origin main
GitHub main
   ↓
GitHub Pages
   ↓
Web pública actualizada
```

Si Pages está configurado para desplegar desde `main`, el `push` provoca normalmente un nuevo despliegue.

---

## 8. Error: `fetch first`

Ejemplo:

```text
! [rejected] main -> main (fetch first)
Updates were rejected because the remote contains work that you do not have locally
```

Solución recomendada:

```bash
git pull --rebase origin main
git push origin main
```

No usar `git push --force` salvo que exista una razón clara y se conozcan las consecuencias.

---

## 9. Conflictos durante `git pull --rebase`

Ver los archivos afectados:

```bash
git status
```

Resolver manualmente los conflictos y después:

```bash
git add archivo_resuelto
git rebase --continue
```

Cancelar completamente el rebase:

```bash
git rebase --abort
```

---

## 10. Git LFS

Si aparece:

```text
This repository is configured for Git LFS but 'git-lfs' was not found
```

Instalar Git LFS:

```bash
sudo apt update
sudo apt install -y git-lfs
git lfs install
```

Después:

```bash
git push origin main
```

Comprobar archivos gestionados por LFS:

```bash
git lfs ls-files
```

Comprobar reglas LFS:

```bash
cat .gitattributes
```

---

# GitHub Codespaces

## 11. `.devcontainer/devcontainer.json`

Configuración recomendada:

```json
{
  "name": "Calendario asignaturas",
  "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
  "forwardPorts": [8000],
  "portsAttributes": {
    "8000": {
      "label": "Calendario",
      "onAutoForward": "openPreview"
    }
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "ritwickdey.LiveServer"
      ],
      "settings": {
        "liveServer.settings.port": 8000
      }
    }
  }
}
```

Su función es configurar el entorno de Codespaces: imagen base, puerto, extensiones y ajustes de VS Code. No es una configuración específica de Codex.

---

## 12. Reconstruir el contenedor

Desde Codespaces:

```text
Ctrl + Shift + P
```

Buscar:

```text
Codespaces: Rebuild Container
```

O, según la interfaz:

```text
Dev Containers: Rebuild Container
```

Antes conviene comprobar:

```bash
git status
```

---

# Probar cambios antes del commit

## 13. Live Server

Abrir `index.html` y usar:

```text
Botón derecho → Open with Live Server
```

O:

```text
Go Live
```

Con la configuración anterior debería usar el puerto `8000`.

En Codespaces abrir la pestaña:

```text
PORTS
```

Y después:

```text
Open in Browser
```

Esto permite probar cambios sin hacer `git add`, `git commit` ni `git push`.

---

## 14. Si Live Server abre otro puerto

Comprobar la pestaña `PORTS`. Si aparece, por ejemplo, `5500`, puede abrirse igualmente desde allí.

Para fijar el puerto `8000`:

```json
"settings": {
  "liveServer.settings.port": 8000
}
```

---

## 15. Servidor alternativo con Node

Comprobar Node:

```bash
node -v
```

Si existe:

```bash
npx serve .
```

O:

```bash
npx http-server .
```

Codespaces detectará normalmente el puerto utilizado.

---

# GitHub Pages

## 16. Configuración recomendada

En GitHub:

```text
Repository
→ Settings
→ Pages
```

Configuración:

```text
Source: Deploy from a branch
Branch: main
Folder: /(root)
```

Para este proyecto estático no es necesario un proceso de build.

---

## 17. URL pública

```text
https://raul27868.github.io/calendario-asignaturas/
```

---

## 18. Comprobar despliegues

En GitHub:

```text
Repository
→ Actions
→ pages build and deployment
```

Comprobar:

- estado;
- fecha;
- commit asociado;
- errores.

Un despliegue correcto debería aparecer en verde.

---

## 19. Pages no muestra los últimos cambios

Primero:

```bash
git fetch origin
git log -1 --oneline
git log origin/main -1 --oneline
```

Si son distintos, comprobar:

```bash
git log origin/main..HEAD --oneline
```

Si aparecen commits locales pendientes:

```bash
git push origin main
```

Después revisar:

```text
GitHub → Actions → pages build and deployment
```

---

## 20. Descartar caché del navegador

Recarga forzada:

```text
Ctrl + Shift + R
```

También se puede probar una ventana privada/incógnito o añadir temporalmente un parámetro:

```text
https://raul27868.github.io/calendario-asignaturas/?v=2
```

Si incluso en incógnito aparece una versión antigua, comprobar antes el commit desplegado por Pages.

---

# Codex y metaprogramación

## 21. `AGENTS.md`

`AGENTS.md` sirve para indicarle a Codex cómo trabajar en este repositorio.

Principios recomendados:

```text
- Mantener index.html autocontenido.
- No añadir frameworks ni npm sin necesidad.
- Hacer cambios localizados.
- No leer el repositorio completo si no es necesario.
- Evitar refactorizaciones no solicitadas.
- Probar antes de cerrar un cambio.
- No hacer push salvo petición explícita.
- No crear commits salvo petición explícita.
```

---

## 22. Economía de recursos Codex

Flujo recomendado:

```text
localizar
→ modificar
→ probar
→ detenerse
```

Evitar:

```text
leer todo
→ rediseñar arquitectura
→ reescribir mucho código
→ documentar extensamente
```

Prompt útil para Codex:

```text
Antes de modificar, localiza solo las funciones y estilos implicados.
No reestructures código no relacionado.
Al terminar, resume brevemente archivos modificados y pruebas realizadas.
No hagas commit ni push.
```

---

# Diagnóstico rápido

## 23. Estado general

```bash
git status
git branch --show-current
git remote -v
git log --oneline -5
```

## 24. ¿Tengo cambios locales sin publicar?

```bash
git fetch origin
git log origin/main..HEAD --oneline
```

## 25. ¿GitHub tiene cambios que yo no tengo?

```bash
git fetch origin
git log HEAD..origin/main --oneline
```

## 26. Comparar local con remoto

```bash
git diff origin/main..HEAD
```

## 27. Ver archivos cambiados entre local y GitHub

```bash
git diff --name-status origin/main..HEAD
```

---

# Flujo corto diario

```bash
git status

# trabajar y probar con Live Server

git diff

git add index.html

git diff --cached

git commit -m "Descripción del cambio"

git pull --rebase origin main

git push origin main
```

Después:

```text
GitHub → Actions → pages build and deployment
```

Y comprobar:

```text
https://raul27868.github.io/calendario-asignaturas/
```

---

# Regla rápida de seguridad

Antes de cualquier operación importante:

```bash
git status
```

Antes de publicar:

```bash
git diff --cached
```

Antes de forzar cualquier operación:

```bash
git log --oneline --decorate --graph --all -12
```

Evitar `--force` salvo que exista una razón explícita y se haya revisado el historial.
