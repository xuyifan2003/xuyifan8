class Population {

  float mutationRate;          
  Rocket[] population;        
  ArrayList<Rocket> matingPool;    
  int generations;         


   Population(float m, int num) {
    mutationRate = m;
    population = new Rocket[num];
    matingPool = new ArrayList<Rocket>();
    generations = 0;
   
    for (int i = 0; i < population.length; i++) {
      PVector location = new PVector(width/2,height+20);
      population[i] = new Rocket(location, new DNA());
    }
  }

  void live () {

    for (int i = 0; i < population.length; i++) {
      population[i].run();
    }
  }


  void fitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
  }

  void selection() {

    matingPool.clear();

    float maxFitness = getMaxFitness();

    
    for (int i = 0; i < population.length; i++) {
      float fitnessNormal = map(population[i].getFitness(),0,maxFitness,0,1);
      int n = (int) (fitnessNormal * 100);  // Arbitrary multiplier
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }

  
  void reproduction() {
    
    for (int i = 0; i < population.length; i++) {
      
      int m = int(random(matingPool.size()));
      int d = int(random(matingPool.size()));
      
      Rocket mom = matingPool.get(m);
      Rocket dad = matingPool.get(d);
      
      DNA momgenes = mom.getDNA();
      DNA dadgenes = dad.getDNA();
    
      DNA child = momgenes.crossover(dadgenes);
     
      child.mutate(mutationRate);
     
      PVector location = new PVector(width/2,height+20);
      population[i] = new Rocket(location, child);
    }
    generations++;
  }

  int getGenerations() {
    return generations;
  }

  
  float getMaxFitness() {
    float record = 0;
    for (int i = 0; i < population.length; i++) {
       if(population[i].getFitness() > record) {
         record = population[i].getFitness();
       }
    }
    return record;
  }

}
