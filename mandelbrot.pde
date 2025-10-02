// Parámetros de visualización
float xmin = -2.5;
float xmax = 1.0;
float ymin = -1.25;
float ymax = 1.25;

int maxIterations = 100;
float zoom = 1.0;

// Variables para animación automática
boolean autoExplore = false;
float exploreTime = 0;

// Paleta de colores
int colorScheme = 0;
int totalColorSchemes = 4;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  noLoop();
  drawMandelbrot();
}

void draw() {
  if (autoExplore) {
    // Modo explorador automático
    exploreTime += 0.02;
    
    // Zoom oscilante
    zoom = 1.0 + sin(exploreTime) * 0.5;
    
    // Cambiar esquema de color periódicamente
    if (frameCount % 120 == 0) {
      colorScheme = (colorScheme + 1) % totalColorSchemes;
    }
    
    // Movimiento suave por el plano complejo
    float centerX = -0.5 + cos(exploreTime * 0.5) * 0.3;
    float centerY = sin(exploreTime * 0.3) * 0.3;
    
    float w = 3.5 / zoom;
    float h = (w * height) / width;
    
    xmin = centerX - w / 2;
    xmax = centerX + w / 2;
    ymin = centerY - h / 2;
    ymax = centerY + h / 2;
    
    drawMandelbrot();
  }
}

void drawMandelbrot() {
  loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      // Mapear coordenadas de píxel a plano complejo
      float a = map(x, 0, width, xmin, xmax);
      float b = map(y, 0, height, ymin, ymax);
      
      float ca = a;
      float cb = b;
      
      int n = 0;
      float z = 0;
      
      // Iteración de Mandelbrot
      while (n < maxIterations) {
        float aa = a * a - b * b;
        float bb = 2 * a * b;
        
        a = aa + ca;
        b = bb + cb;
        
        // Calcular magnitud
        z = sqrt(a * a + b * b);
        
        if (z > 16) break;
        n++;
      }
      
      // Calcular color según iteraciones
      color c = getColor(n, z);
      
      int pix = x + y * width;
      pixels[pix] = c;
    }
  }
  
  updatePixels();
  
  // Mostrar información
  drawInfo();
}

color getColor(int iterations, float z) {
  if (iterations == maxIterations) {
    return color(0, 0, 0);
  }
  
  // Suavizado de color
  float smooth = iterations + 1 - log(log(z)) / log(2);
  
  float hue, saturation, brightness;
  
  switch(colorScheme) {
    case 0: // Arcoíris
      hue = map(smooth, 0, maxIterations, 0, 360);
      saturation = 100;
      brightness = map(smooth, 0, maxIterations, 50, 100);
      break;
      
    case 1: // Fuego
      hue = map(smooth, 0, maxIterations, 0, 60);
      saturation = 100;
      brightness = map(smooth, 0, maxIterations, 30, 100);
      break;
      
    case 2: // Océano
      hue = map(smooth, 0, maxIterations, 180, 240);
      saturation = map(smooth, 0, maxIterations, 60, 100);
      brightness = map(smooth, 0, maxIterations, 40, 100);
      break;
      
    case 3: // Púrpura-Rosa
      hue = map(smooth, 0, maxIterations, 280, 340);
      saturation = 90;
      brightness = map(smooth, 0, maxIterations, 50, 100);
      break;
      
    default:
      hue = 0;
      saturation = 0;
      brightness = map(smooth, 0, maxIterations, 0, 100);
  }
  
  return color(hue, saturation, brightness);
}

void drawInfo() {
  fill(255);
  rect(0, 0, 280, 150);
  
  fill(0);
  textSize(12);
  text("CONTROLES:", 10, 20);
  text("Click: Hacer zoom en punto", 10, 40);
  text("1-4: Cambiar paleta de colores", 10, 55);
  text("A: Modo explorador automático", 10, 70);
  text("R: Reiniciar vista", 10, 85);
  text("+/-: Aumentar/Reducir iteraciones", 10, 100);
  text("", 10, 115);
  text("Iteraciones: " + maxIterations, 10, 130);
  text("Zoom: " + nf(zoom, 0, 2) + "x", 150, 130);
}

void mousePressed() {
  if (!autoExplore) {
    // Calcular punto en plano complejo donde se hizo click
    float clickX = map(mouseX, 0, width, xmin, xmax);
    float clickY = map(mouseY, 0, height, ymin, ymax);
    
    // Hacer zoom centrado en ese punto
    zoom *= 2.0;
    
    float w = 3.5 / zoom;
    float h = (w * height) / width;
    
    xmin = clickX - w / 2;
    xmax = clickX + w / 2;
    ymin = clickY - h / 2;
    ymax = clickY + h / 2;
    
    redraw();
  }
}

void keyPressed() {
  // Cambiar esquema de color
  if (key >= '1' && key <= '4') {
    colorScheme = key - '1';
    redraw();
  }
  
  // Modo explorador automático
  if (key == 'a' || key == 'A') {
    autoExplore = !autoExplore;
    if (autoExplore) {
      loop();
    } else {
      noLoop();
    }
  }
  
  // Reiniciar
  if (key == 'r' || key == 'R') {
    xmin = -2.5;
    xmax = 1.0;
    ymin = -1.25;
    ymax = 1.25;
    zoom = 1.0;
    maxIterations = 100;
    exploreTime = 0;
    autoExplore = false;
    noLoop();
    redraw();
  }
  
  // Aumentar iteraciones
  if (key == '+' || key == '=') {
    maxIterations += 20;
    redraw();
  }
  
  // Reducir iteraciones
  if (key == '-' || key == '_') {
    maxIterations = max(20, maxIterations - 20);
    redraw();
  }
}
