# Visualizadores de Fractales en Processing

Este proyecto contiene dos visualizadores interactivos de fractales clásicos implementados en Processing: el conjunto de Mandelbrot y el triángulo de Sierpinski.

## 📋 Requisitos

- [Processing](https://processing.org/download) (versión 3.0 o superior)

## 🎨 Fractales Incluidos

### 1. Mandelbrot (`mandelbrot.pde`)

Visualizador del conjunto de Mandelbrot con capacidades de zoom interactivo y múltiples esquemas de color.

#### Características

- **Zoom interactivo**: Haz clic en cualquier punto para hacer zoom
- **4 paletas de colores**: Arcoíris, Fuego, Océano y Púrpura-Rosa
- **Modo explorador automático**: Navegación y zoom automáticos
- **Iteraciones ajustables**: Controla el nivel de detalle
- **Suavizado de color**: Algoritmo de coloración suave para transiciones más naturales

#### Controles

- **Click izquierdo**: Hacer zoom 2x en el punto seleccionado
- **1-4**: Cambiar entre esquemas de color
- **A**: Activar/desactivar modo explorador automático
- **R**: Reiniciar vista al estado inicial
- **+/-**: Aumentar/reducir número de iteraciones (±20)

### 2. Sierpinski (`sierpinski.pde`)

Visualizador animado del triángulo de Sierpinski con rotación y colores dinámicos.

#### Características

- **Recursión variable**: Ajusta la profundidad del fractal (1-8 niveles)
- **Rotación automática**: Giro suave y continuo
- **Colores animados**: Gradiente de colores que cambia dinámicamente
- **Múltiples formas de control**: Teclado y rueda del mouse

#### Controles

- **↑/↓** o **rueda del mouse**: Aumentar/disminuir profundidad
- **R**: Activar/desactivar rotación
- **C**: Activar/desactivar animación de colores
- **ESPACIO**: Reiniciar a valores predeterminados

## 🚀 Cómo usar

1. Descarga e instala [Processing](https://processing.org/download)
2. Abre el archivo `.pde` que quieras visualizar en Processing
3. Presiona el botón **Run** (▶) o usa `Ctrl+R` / `Cmd+R`
4. Interactúa con el fractal usando los controles descritos

## 🎓 Conceptos matemáticos

### Conjunto de Mandelbrot

El conjunto de Mandelbrot es el conjunto de puntos `c` en el plano complejo para los cuales la iteración:

```
z₀ = 0
zₙ₊₁ = zₙ² + c
```

permanece acotada. Es uno de los fractales más famosos y exhibe una complejidad infinita a cualquier nivel de zoom.

### Triángulo de Sierpinski

El triángulo de Sierpinski se construye recursivamente:
1. Comenzando con un triángulo equilátero
2. Dividirlo en 4 triángulos más pequeños
3. Remover el triángulo central
4. Repetir el proceso con los 3 triángulos restantes

## 🎨 Personalización

Puedes modificar los parámetros iniciales en cada archivo:

**Mandelbrot:**
- `maxIterations`: Número de iteraciones (mayor = más detalle, más lento)
- `xmin, xmax, ymin, ymax`: Región inicial del plano complejo
- Modifica la función `getColor()` para crear tus propios esquemas de color

**Sierpinski:**
- `depth`: Profundidad inicial (1-8)
- `rotationSpeed`: Velocidad de rotación
- Modifica los valores de `hue`, `saturation` y `brightness` en `drawTriangle()` para cambiar los colores

## 📝 Notas técnicas

- Ambos programas usan el modo de color HSB para facilitar la generación de paletas
- El Mandelbrot usa `loadPixels()` y `updatePixels()` para optimización
- El Sierpinski usa recursión para generar el fractal de manera elegante
- Resolución de ventana: 800x800 píxeles (modificable en `size()`)

## 🐛 Solución de problemas

- Si la visualización es lenta, reduce el número de iteraciones en Mandelbrot o la profundidad en Sierpinski
- Si los colores no se ven correctamente, verifica que tu versión de Processing soporte el modo HSB
- En caso de que el programa no responda, intenta reducir el tamaño de la ventana


---

**¡Disfruta explorando el fascinante mundo de los fractales! 🌀✨**
