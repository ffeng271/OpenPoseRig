import peasy.PeasyCam;

PeasyCam cam;

float[] origData = { 6.89390000e+01, 0.00000000e+00, 1.07407105e+02, -5.04243315e+02, -1.08199263e+01, 1.76477921e+02, -7.32436376e+02, -8.15188640e+02, -5.43730003e+02, -9.98518435e+02, -3.98298507e+02, -9.43728179e+02,  5.73829367e+01, 1.66477287e+02, -6.34742621e+02, 5.70942898e+01,  1.65182437e+02, -6.29355959e+02, 6.42114399e+02, 1.08181013e+01,  3.83371231e+01, 9.59126910e+00, -2.11422961e+02, -5.55654807e+02, -6.53139382e+02, 3.65415574e+02, -7.89776939e+02, 5.76747600e+01,  1.66665977e+02, -6.41229759e+02, 5.75299160e+01, 1.63713810e+02, -6.29027959e+02, 6.89402166e+01, -1.93000576e-02, 1.07493116e+02,  1.07474392e+03, 6.20385744e+00, -5.91728611e+01, 1.98334386e+03, -1.98337678e+02, -4.85954497e+02, 2.02842139e+03, -6.00330048e+02, -5.46053724e+02, 2.24005612e+03, -5.37629686e+02, -4.89292646e+02,  7.46143780e+01, -9.76974016e+01, 5.42496010e+02, 2.58131773e+03, -3.56208948e+02, -6.61271268e+02, 2.96295210e+03, -1.67953383e+03, -1.18213628e+03, -3.96024496e+02, -1.66358559e+03, 1.35997638e+03,  7.02048582e+01, -2.82526049e+01, 2.27577684e+02, 7.05180070e+01, -3.52080548e+01, 2.59187354e+02, 6.98235440e+01, -2.56307189e+01,  2.15202461e+02, 6.98235440e+01, -2.56307189e+01, 2.15202461e+02,  7.46143780e+01, -9.76974016e+01, 5.42496010e+02, 1.11547895e+03,  1.36023609e+01, -2.16239150e+02, -8.77476746e+02, -1.52139013e+02,  5.23489187e+02, -6.21281643e+02, -9.32030040e+02, 1.18021564e+03,  6.98095690e+01, -3.73902498e+01, 2.76071674e+02, 7.03388251e+01, -4.47207875e+01, 3.08291357e+02, 6.94635911e+01, -3.68342864e+01,  2.73274878e+02, 6.94635911e+01, -3.68342864e+01, 2.73274878e+02 };

float globalScale = 0.1;
PVector offset = new PVector(210,-20,-522);

ArrayList<PVector> points = new ArrayList<PVector>();

void setup() {
  size(640, 480, P3D);
  cam = new PeasyCam(this, 400);

  for (int i=0; i<origData.length; i+=3) {
    PVector p = new PVector(origData[i+0], origData[i+1], origData[i+2]);
    p.add(offset).mult(globalScale);
    points.add(p);
  }

  println("origData length: " + origData.length + "   points length: " + points.size());

}

void draw() {
  background(127, 63, 155);
  
  lights();
  
  for (int i=0; i<points.size(); i++) {
    PVector p = points.get(i);
  
    strokeWeight(1);
    stroke(0);
    fill(255);
    pushMatrix();
    translate(p.x, p.y, p.z);
    sphereDetail(2);
    sphere(10);
    popMatrix();
  }
  
  PVector p_hip = points.get(0);
  PVector p_neck = points.get(13);
  PVector p_thorax = points.get(13);
  PVector p_spine = points.get(24);

  PVector[] body = { p_hip, p_thorax, p_spine, p_neck };
  drawChain(body);
}

void drawChain(PVector[] p) {
  for (int i=1; i<p.length; i++) {
    drawLine(p[i-1], p[i]);
  }
}

void drawLine(PVector pp, PVector p) {
  strokeWeight(5);
  stroke(0);
  line(pp.x, pp.y, pp.z, p.x, p.y, p.z);
}