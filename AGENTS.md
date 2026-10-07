# AGENTS.md

## Proyecto

Editor de calendario académico en HTML, inspirado visualmente en calendarios VIU.

## Regla principal

Mantener la aplicación autocontenida en `index.html`:

- HTML, CSS y JavaScript en un solo fichero.
- No introducir frameworks, paquetes npm ni proceso de build sin pedirlo expresamente.
- Priorizar JavaScript nativo y CSS estándar.
- Debe funcionar abriendo `index.html` directamente o sirviéndolo con un servidor HTTP estático.

## Funcionalidad que debe conservarse

- Año configurable.
- Mes inicial y final configurables.
- Título respetando mayúsculas y minúsculas introducidas por el usuario.
- Edición configurable.
- Calendario en 3 columnas en escritorio.
- En impresión/PDF los meses deben conservar siempre 3 columnas.
- Asignaturas/periodos con nombre y color.
- Solo una asignatura/periodo activa a la vez.
- Clic en un día:
  - si no tiene el color activo, asignarlo;
  - si ya tiene el color activo, desmarcarlo;
  - si tiene otro color, sustituirlo por el activo.
- Leyenda automática.
- Colores visibles al imprimir/PDF.

## Estilo

- Mantener una estética limpia y cercana al calendario de referencia.
- Evitar cambios visuales amplios que no hayan sido solicitados.
- No convertir el proyecto a React/Vue/etc.
- No añadir dependencias externas salvo necesidad justificada.

## Verificación mínima antes de cerrar un cambio

1. Abrir la página sin errores de consola.
2. Comprobar cambio de año y rango de meses.
3. Crear una asignatura/periodo.
4. Marcar, sustituir y desmarcar días.
5. Comprobar la vista de impresión:
   - tres columnas;
   - colores visibles;
   - leyenda presente;
   - controles de edición ocultos.

## Economía de recursos Codex

- Usa la mínima cantidad de contexto necesaria.
- No leas el repositorio completo si el cambio está localizado.
- Empieza por buscar símbolos, ids, clases o funciones concretas.
- No vuelvas a leer archivos ya inspeccionados salvo que hayan cambiado.
- Evita explicaciones largas; responde con resumen breve + archivos modificados + pruebas realizadas.
- Para tareas simples, actúa directamente sin plan extenso.
- Si una petición probablemente exige una exploración amplia, refactorización extensa,
  múltiples archivos o muchas iteraciones:
  1. advierte antes;
  2. explica brevemente por qué puede consumir bastante contexto;
  3. propone dividirla en pasos pequeños;
  4. no inicies la parte costosa hasta recibir confirmación.
- Antes de una operación amplia, intenta una solución localizada.