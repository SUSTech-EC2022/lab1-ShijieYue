clear;clc;
fitFunc = 'objFunc'; % name of objective/fitness function
T = 200; % total number of evaluations
A=0:31;
population_size=10;

[bestSoFarFit, bestSoFarSolution] = simpleEA(fitFunc, T,population_size,A);
