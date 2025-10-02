int depth = 5;
int maxDepth = 8;
int minDepth = 1;

// Altura del triángulo
float triangleHeight;

// Puntos de los vértices del triángulo principal
PVector p1, p2, p3;

// Variables para animación
float angle = 0;
float rotationSpeed = 0.005;

// Variables para colores dinámicos
float hueOffset = 0;
boolean animateColors = true;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  triangleHeight = sqrt(3) / 2 * width;
  
  // Vértices del triángulo principal
  p1 = new PVector(width / 2, height * 0.1);
  p2 = new PVector(width * 0.1, height * 0.9);
  p3 = new PVector(width * 0.9, height * 0.9);
}

void draw() {
  background(0);
  
  // Actualizar offset de color para animación
  if (animateColors) {
    hueOffset += 0.5;
    if (hueOffset > 360) hueOffset = 0;
  }
  
  // Guardar estado de transformación
  pushMatrix();
  
  // Rotar desde el centro
  translate(width / 2, height / 2);
  rotate(angle);
  translate(-width / 2, -height / 2);
  
  // Dibujar el fractal
  noStroke();
  drawTriangle(depth, p1, p2, p3, 0);
  
  popMatrix();
  
  // Actualizar ángulo de rotación
  angle += rotationSpeed;
  
  // Información en pantalla
  fill(255);
  textSize(16);
  text("Profundidad: " + depth, 10, 25);
  text("↑/↓: Cambiar profundidad", 10, 50);
  text("R: Activar/Desactivar rotación", 10, 75);
  text("C: Activar/Desactivar colores animados", 10, 100);
  text("ESPACIO: Reiniciar", 10, 125);
}

void drawTriangle(int d, PVector p1, PVector p2, PVector p3, int level) {
  if (d == 0) {
    // Calcular color basado en la profundidad
    float hue = (hueOffset + level * 30) % 360;
    float saturation = map(level, 0, depth, 50, 100);
    float brightness = map(level, 0, depth, 60, 100);
    
    fill(hue, saturation, brightness, 200);
    triangle(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
  } else {
    // Calcular puntos medios
    PVector mid1 = new PVector((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
    PVector mid2 = new PVector((p2.x + p3.x) / 2, (p2.y + p3.y) / 2);
    PVector mid3 = new PVector((p1.x + p3.x) / 2, (p1.y + p3.y) / 2);
    
    // Recursión en los tres sub-triángulos
    drawTriangle(d - 1, p1, mid1, mid3, level + 1);
    drawTriangle(d - 1, mid1, p2, mid2, level + 1);
    drawTriangle(d - 1, mid3, mid2, p3, level + 1);
  }
}

void keyPressed() {
  // Aumentar profundidad
  if (keyCode == UP && depth < maxDepth) {
    depth++;
  }
  
  // Disminuir profundidad
  if (keyCode == DOWN && depth > minDepth) {
    depth--;
  }
  
  // Activar/desactivar rotación
  if (key == 'r' || key == 'R') {
    if (rotationSpeed == 0) {
      rotationSpeed = 0.005;
    } else {
      rotationSpeed = 0;
    }
  }
  
  // Activar/desactivar animación de colores
  if (key == 'c' || key == 'C') {
    animateColors = !animateColors;
  }
  
  // Reiniciar
  if (key == ' ') {
    angle = 0;
    hueOffset = 0;
    depth = 5;
  }
}

// Control con rueda del mouse
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if (e < 0 && depth < maxDepth) {
    depth++;
  } else if (e > 0 && depth > minDepth) {
    depth--;
  }
}
