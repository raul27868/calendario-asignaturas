# Calendario de asignaturas

Editor web de calendario académico inspirado en el formato visual de VIU.

## Estado actual

La aplicación está contenida en un único fichero `index.html`.

Funciones disponibles:

- selección de año;
- selección de mes inicial y final;
- título y edición;
- calendario en tres columnas;
- creación de asignaturas y periodos con color;
- intercambio de colores entre asignaturas y periodos, conservando los días asociados a cada uno;
- selección de una asignatura/periodo activo;
- marcado y desmarcado de días con clic;
- leyenda automática;
- carga local de logo;
- impresión / exportación a PDF;
- tres columnas forzadas también en impresión.

## Trabajar en GitHub Codespaces

1. Abre el repositorio en GitHub.
2. Pulsa **Code > Codespaces > Create codespace on main**.
3. En la terminal ejecuta:

```bash
python3 -m http.server 8000
```

4. Codespaces detectará el puerto 8000. Abre el enlace del puerto reenviado.

No hay dependencias ni proceso de compilación.

## Estructura

- `index.html`: aplicación completa.
- `.devcontainer/devcontainer.json`: configuración básica de Codespaces.
- `AGENTS.md`: instrucciones de trabajo para Codex.

## Criterio de desarrollo

Por ahora se mantiene el requisito de **HTML autocontenido en un solo fichero**. No separar CSS o JavaScript salvo decisión explícita posterior.
