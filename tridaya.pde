// Animasi Kebudayaan Indonesia - 3 Menit
// Tema: Wayang, Batik, dan Hanoman

// Variabel global untuk timing dan scene
int startTime;
int currentScene = 0;
int totalScenes = 3;
float sceneProgress = 0;

// Variabel untuk animasi wayang
float wayangX1 = 100;
float wayangX2 = 700;
float wayangY = 300;
float wayangMove = 0;
boolean wayangFighting = false;

// Variabel untuk animasi batik
float batikPattern = 0;
ArrayList<PVector> batikPoints;
color[] batikColors = {#8B4513, #DAA520, #CD853F, #D2691E};

// Variabel untuk animasi Hanoman
float hanoManX = 400;
float hanoManY = 300;
float hanoManJump = 0;
float cloudX = 0;
boolean hanoManFlying = false;

// Setup
void setup() {
  size(800, 600);
  startTime = millis();
  
  // Inisialisasi pola batik
  batikPoints = new ArrayList<PVector>();
  for (int i = 0; i < 50; i++) {
    batikPoints.add(new PVector(random(width), random(height)));
  }
}

void draw() {
  // Hitung waktu dan scene
  int elapsed = millis() - startTime;
  float totalTime = 180000; // 3 menit dalam milliseconds
  float sceneTime = totalTime / totalScenes;
  
  currentScene = (int)(elapsed / sceneTime);
  sceneProgress = (elapsed % sceneTime) / sceneTime;
  
  // Batasi scene
  if (currentScene >= totalScenes) {
    currentScene = totalScenes - 1;
    sceneProgress = 1.0;
  }
  
  // Render scene berdasarkan waktu
  switch (currentScene) {
    case 0:
      drawWayangScene();
      break;
    case 1:
      drawBatikScene();
      break;
    case 2:
      drawHanoManScene();
      break;
  }
  
  // Tampilkan info scene
  drawSceneInfo();
}

// Scene 1: Pertarungan Wayang
void drawWayangScene() {
  // Background gradient
  for (int y = 0; y < height; y++) {
    float alpha = map(y, 0, height, 0, 1);
    color c = lerpColor(color(255, 215, 0), color(139, 69, 19), alpha);
    stroke(c);
    line(0, y, width, y);
  }
  
  // Layar wayang
  fill(255, 255, 240, 200);
  rect(50, 50, width-100, height-100);
  
  // Animasi gerakan wayang
  wayangMove += 0.1;
  wayangX1 += sin(wayangMove) * 2;
  wayangX2 -= sin(wayangMove) * 2;
  
  // Gambar wayang kiri (pahlawan)
  pushMatrix();
  translate(wayangX1, wayangY);
  drawWayangFigure(true);
  popMatrix();
  
  // Gambar wayang kanan (antagonis)
  pushMatrix();
  translate(wayangX2, wayangY);
  drawWayangFigure(false);
  popMatrix();
  
  // Efek bayangan
  fill(0, 0, 0, 100);
  ellipse(wayangX1, wayangY + 150, 80, 20);
  ellipse(wayangX2, wayangY + 150, 80, 20);
  
  // Teks judul
  fill(139, 69, 19);
  textSize(24);
  textAlign(CENTER);
  text("PERTARUNGAN WAYANG", width/2, 30);
}

// Scene 2: Proses Membatik
void drawBatikScene() {
  // Background kain
  background(245, 245, 220);
  
  // Pola batik yang berkembang
  batikPattern += 0.05;
  
  // Gambar pola batik
  for (int i = 0; i < batikPoints.size(); i++) {
    PVector point = batikPoints.get(i);
    float size = sin(batikPattern + i * 0.1) * 10 + 15;
    
    // Warna berubah seiring waktu
    fill(batikColors[i % batikColors.length]);
    noStroke();
    
    // Pola melingkar
    ellipse(point.x, point.y, size, size);
    
    // Pola tambahan
    if (i % 3 == 0) {
      stroke(batikColors[(i+1) % batikColors.length]);
      strokeWeight(2);
      noFill();
      ellipse(point.x, point.y, size * 1.5, size * 1.5);
    }
  }
  
  // Simulasi tangan membatik
  float handX = width/2 + sin(batikPattern * 2) * 100;
  float handY = height/2 + cos(batikPattern * 2) * 50;
  
  // Gambar tangan dan canting
  fill(222, 184, 135);
  ellipse(handX, handY, 30, 40);
  
  // Canting
  stroke(101, 67, 33);
  strokeWeight(3);
  line(handX, handY, handX + 20, handY - 10);
  fill(101, 67, 33);
  ellipse(handX + 20, handY - 10, 8, 8);
  
  // Tetes malam
  if (frameCount % 10 == 0) {
    fill(255, 255, 0, 150);
    ellipse(handX + 25, handY - 5, 5, 5);
  }
  
  // Teks judul
  fill(139, 69, 19);
  textSize(24);
  textAlign(CENTER);
  text("SENI MEMBATIK", width/2, 30);
}

// Scene 3: Hanoman Terbang
void drawHanoManScene() {
  // Background langit
  for (int y = 0; y < height; y++) {
    float alpha = map(y, 0, height, 0, 1);
    color c = lerpColor(color(135, 206, 235), color(255, 218, 185), alpha);
    stroke(c);
    line(0, y, width, y);
  }
  
  // Awan bergerak
  cloudX += 1;
  if (cloudX > width + 100) cloudX = -100;
  
  drawCloud(cloudX, 100);
  drawCloud(cloudX + 200, 150);
  drawCloud(cloudX - 150, 120);
  
  // Animasi lompatan Hanoman
  hanoManJump += 0.15;
  hanoManY = 300 + sin(hanoManJump) * 100;
  hanoManX = 400 + cos(hanoManJump * 0.5) * 150;
  
  // Gambar Hanoman
  pushMatrix();
  translate(hanoManX, hanoManY);
  drawHanoMan();
  popMatrix();
  
  // Efek angin
  for (int i = 0; i < 10; i++) {
    stroke(255, 255, 255, 100);
    strokeWeight(2);
    float windX = hanoManX - 50 + i * 10;
    float windY = hanoManY + random(-20, 20);
    line(windX, windY, windX - 30, windY + random(-10, 10));
  }
  
  // Teks judul
  fill(139, 69, 19);
  textSize(24);
  textAlign(CENTER);
  text("HANOMAN SANG PAHLAWAN", width/2, 30);
}

// Fungsi untuk menggambar figur wayang
void drawWayangFigure(boolean isHero) {
  color figureColor = isHero ? color(255, 215, 0) : color(139, 0, 0);
  
  // Tubuh
  fill(figureColor);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, 40, 80);
  
  // Kepala
  ellipse(0, -50, 35, 35);
  
  // Mahkota/topi
  fill(isHero ? color(255, 215, 0) : color(139, 0, 0));
  triangle(-20, -65, 0, -80, 20, -65);
  
  // Lengan
  line(-20, -10, -40, 10);
  line(20, -10, 40, 10);
  
  // Kaki
  line(-10, 30, -20, 60);
  line(10, 30, 20, 60);
  
  // Senjata
  if (isHero) {
    stroke(101, 67, 33);
    strokeWeight(3);
    line(40, 10, 60, -10);
    line(60, -10, 55, -20);
  } else {
    stroke(139, 0, 0);
    strokeWeight(3);
    line(-40, 10, -60, -10);
    line(-60, -10, -55, -20);
  }
}

// Fungsi untuk menggambar Hanoman
void drawHanoMan() {
  // Bayangan
  fill(0, 0, 0, 50);
  noStroke();
  ellipse(0, 80, 60, 20);
  
  // Tubuh
  fill(255, 228, 196);
  stroke(0);
  strokeWeight(2);
  ellipse(0, 0, 50, 70);
  
  // Kepala
  ellipse(0, -40, 40, 40);
  
  // Telinga kera
  ellipse(-25, -45, 15, 20);
  ellipse(25, -45, 15, 20);
  
  // Mata
  fill(0);
  ellipse(-8, -45, 5, 5);
  ellipse(8, -45, 5, 5);
  
  // Mulut
  stroke(0);
  strokeWeight(1);
  noFill();
  arc(0, -35, 15, 10, 0, PI);
  
  // Lengan
  fill(255, 228, 196);
  stroke(0);
  strokeWeight(2);
  ellipse(-30, -5, 20, 40);
  ellipse(30, -5, 20, 40);
  
  // Kaki
  ellipse(-15, 40, 18, 35);
  ellipse(15, 40, 18, 35);
  
  // Ekor
  stroke(0);
  strokeWeight(3);
  noFill();
  arc(25, 20, 40, 40, 0, PI);
  
  // Mahkota
  fill(255, 215, 0);
  stroke(0);
  strokeWeight(1);
  triangle(-15, -55, 0, -70, 15, -55);
}

// Fungsi untuk menggambar awan
void drawCloud(float x, float y) {
  fill(255, 255, 255, 200);
  noStroke();
  ellipse(x, y, 60, 40);
  ellipse(x + 30, y, 70, 50);
  ellipse(x + 60, y, 60, 40);
  ellipse(x + 30, y - 20, 50, 30);
}

// Fungsi untuk menampilkan info scene
void drawSceneInfo() {
  // Progress bar
  fill(0, 0, 0, 100);
  rect(20, height - 40, width - 40, 20);
  
  fill(139, 69, 19);
  float progressWidth = map(sceneProgress, 0, 1, 0, width - 40);
  rect(20, height - 40, progressWidth, 20);
  
  // Info scene
  fill(255);
  textSize(12);
  textAlign(LEFT);
  String sceneNames[] = {"Pertarungan Wayang", "Seni Membatik", "Hanoman Terbang"};
  text("Scene " + (currentScene + 1) + ": " + sceneNames[currentScene], 25, height - 45);
  
  // Timer
  int elapsed = millis() - startTime;
  int seconds = (elapsed / 1000) % 60;
  int minutes = elapsed / 60000;
  textAlign(RIGHT);
  text(nf(minutes, 2) + ":" + nf(seconds, 2), width - 25, height - 45);
}

// Fungsi untuk restart animasi
void keyPressed() {
  if (key == 'r' || key == 'R') {
    startTime = millis();
    currentScene = 0;
    sceneProgress = 0;
  }
}
