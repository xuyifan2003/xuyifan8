int lifetime;  

Population population;  

int lifeCounter;         

PVector target;       

void setup() {
  size(800, 600);
  smooth();

  lifetime = 200;

  
  lifeCounter = 0;
  
  target = new PVector(width/2, 24);


  float mutationRate = 0.01;
  population = new Population(mutationRate, 50);

}

void draw() {
  background(255);

 
  fill(255);
  rect(target.x,target.y,60,24);
  fill(random(255),random(255),random(255));
  text("home",target.x-10,target.y+300);
  textSize(50);


  
  if (lifeCounter < lifetime) {
    population.live();
    lifeCounter++;
   
  } 
  else {
    lifeCounter = 0;
    population.fitness();
    population.selection();
    population.reproduction();
  }

 
  fill(0);
  textSize(50);
  text("Generation #: " + population.getGenerations(), 10, 25);
  text("Cycles left: " + (lifetime-lifeCounter), 10, 70);
}


void mousePressed() {
  target.x = mouseX;
  target.y = mouseY;
}
