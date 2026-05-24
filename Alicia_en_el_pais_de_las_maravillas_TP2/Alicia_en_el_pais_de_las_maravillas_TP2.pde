PImage conejo;
PImage aliciaCayendo;
PImage fondo;
float t = 0;
float scrollY = 0;
float fondoH;
PFont fuenteTitulo;
boolean iniciado  = false; 
boolean terminado = false;


void setup() {
  size(640, 480);
  conejo = loadImage("conejo.png");
  aliciaCayendo= loadImage("aliciacayendo.png");
  fondo  = loadImage("fondocayendoxelpozo.png");
  fondoH = fondo.height * (640.0 / fondo.width);
  fuenteTitulo = loadFont("FootlightMTLight-32.vlw");
}

void draw() {
  background(0);
  t = t + 0.05;
  

  if (!iniciado) {dibujarInicio();return;}
  if (terminado) {dibujarFin();return;}
  
  
  scrollY = scrollY - 2;
  float limite = -(fondoH - height);
  if (scrollY <= limite) {
    scrollY = limite;
    terminado = true;
  }
  //fondo
  image(fondo, 0, scrollY, 640, fondoH);
  //conejo
  float conejoAbsY = fondoH * 0.01;
  float conejoPantallaY = conejoAbsY + scrollY;
  float offsetY = sin(t) * 20;
  image(conejo, 220, conejoPantallaY + offsetY, 200, 300);
  
  //alicia cayendo
  float aliciaAbsY = fondoH * 0.20;
  float aliciaPantallaY = aliciaAbsY + scrollY;
  float aliciaOffsetY   = sin(t * 0.9) * 15;
  image(aliciaCayendo, 120, aliciaPantallaY, 500, 450);
  
  //texto del conejo
  float trigger = -(fondoH * 0.03);
  float zonaVisible = 400;
  float fadeZona = 80;
  float distancia = scrollY - trigger;
  
  if (distancia <= 0 && distancia >= -zonaVisible) {
    float d = -distancia;
    float alfa;
    if (d < fadeZona){
    alfa = map ( d, 0, fadeZona, 0, 255); 
  }
  else if (d > zonaVisible-fadeZona) {
    alfa= map(d, zonaVisible-fadeZona, zonaVisible, 255,0);
  }
  else{
    alfa=255;
  }
  
  noStroke();
  fill (0,0,0, alfa*0.6);
  rect(width/2 - 240, height/2 - 70, 480, 140, 12);
  
  
   float textoOY = sin(t * 1.4)*4;
   textFont (fuenteTitulo);
   textSize (20);   
   textAlign (CENTER, CENTER);
   textLeading (30);
   
   fill(255, 238, 170, alfa);
   text("El conejo blanco siempre iba apurado diciendo: \n ¡oh, dios mio! \n ¡Llegare tardisimo", 320, height/2 + textoOY) ;
  }
  //texto de alicia
  float trigger2     = -(fondoH * 0.20);  
  float zona2        = 400;
  float fade2        = 80;
  float distancia2   = scrollY - trigger2;

  if (distancia2 <= 0 && distancia2 >= -zona2) {
    float d2 = -distancia2;

    float alfa2;
    if (d2 < fade2) {
      alfa2 = map(d2, 0, fade2, 0, 255);
    } else if (d2 > zona2 - fade2) {
      alfa2 = map(d2, zona2 - fade2, zona2, 255, 0);
    } else {
      alfa2 = 255;
    }

    // Panel oscuro
    noStroke();
    fill(0, 0, 0, alfa2 * 0.6);
    rect(width/2 - 240, height/2 - 70, 480, 140, 12);

    // Texto
    float textoOY2 = sin(t * 1.4) * 4;
    textFont(fuenteTitulo);
    textSize(20);
    textAlign(CENTER, CENTER);
    textLeading(30);
    fill(255, 238, 170, alfa2);
    text("Sin pensarlo dos veces,\nAlicia comenzo a perseguir al conejo blanco \n saltó por el agujero\n y empezó a caer...", 
         320, height/2 + textoOY2);
  }
}
   
   void dibujarInicio() {
  image(fondo, 0, 0, 640, height);
  noStroke();
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);
  
  float sc = 1.0 + sin(t * 0.8) * 0.025;
  textFont(fuenteTitulo);
  textSize(30 * sc);
  fill(255, 215, 65);
  textAlign(CENTER, CENTER);
  text("Alicia en el País\nde las Maravillas", width/2, 180);
  
  fill(55, 20, 95);
  rect(width/2 - 80, 320, 160, 50, 12);
  fill(255);
  textSize(18);
  text("INICIAR", width/2, 345);
}

void dibujarFin() {
  background(0);
float sc = 1.0 + sin(t * 0.9) * 0.03;
  textFont(fuenteTitulo);
  textSize(46 * sc);
  fill(255, 215, 65);
  textAlign(CENTER, CENTER);
  text("FIN", width/2, 180);
  
  textSize(18);
  fill(210, 228, 255);
  text("Alicia abrió los ojos.\nEstaba de vuelta en el jardín. \n Habia sido todo un sueño.", width/2, 280);
  
  fill(55, 20, 95);
  rect(width/2 - 90, 370, 180, 50, 12);
  fill(255);
  textSize(18);
  text("REINICIAR", width/2, 395);
}
     void mousePressed() {


  if (!iniciado) {
    if (mouseX > width/2 - 80 && mouseX < width/2 + 80 &&
        mouseY > 320           && mouseY < 370) {
      iniciado  = true;
      scrollY   = 0;
      t         = 0;
    }
    return;
  }
  if (terminado) {
    if (mouseX > width/2 - 90 && mouseX < width/2 + 90 &&
        mouseY > 370           && mouseY < 420) {
      iniciado  = false;
      terminado = false;
      scrollY   = 0;
      t         = 0;
    }
  }
}
