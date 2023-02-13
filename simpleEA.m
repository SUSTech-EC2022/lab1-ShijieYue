function [bestSoFarFit ,bestSoFarSolution ...
    ]=simpleEA( ...  % name of your simple EA function
    fitFunc, ... % name of objective/fitness function
    T, ... % total number of evaluations
    population_size, ... % the size of population
    A) % the range of solution


% Check the inputs
if isempty(fitFunc)
  warning(['Objective function not specified, ''' objFunc ''' used']);
  fitFunc = 'objFunc';
end
if ~ischar(fitFunc)
  error('Argument FITFUNC must be a string');
end
if isempty(T)
  warning(['Budget not specified. 1000000 used']);
  T = '1000000';
end
eval(sprintf('objective=@%s;',fitFunc));
% Initialise variables
nbGen = 0; % generation counter
nbEval = 0; % evaluation counter
bestSoFarFit = 0; % best-so-far fitness value
bestSoFarSolution = NaN; % best-so-far solution
%recorders
fitness_gen=[]; % record the best fitness so far
solution_gen=[];% record the best phenotype of each generation
fitness_pop=[];% record the best fitness in current population 
%% Below starting your code

% Initialise a population
%% TODO

population=A(randi(numel(A),1,population_size));
binStr_population = dec2bin(population); 

% Evaluate the initial population
%% TODO
fitness_population=objFunc(population);
% Start the loop
while (nbEval<T) 
% Reproduction (selection, crossver)
%% TODO
possible=fitness_population/(sum(fitness_population));
[sortreuslt,index]=sort(possible,'descend');

population_new=[];

offspring1=[];
offspring2=[];
for k=1:population_size/2
parent1=rand(1);
parent2=rand(1);
parent1_index=[];
parent2_index=[];
parent1_location=parent1;
parent2_location=parent2;

j=1;
while j<=length(sortreuslt)
    parent1_location=parent1_location-sortreuslt(j);
    if parent1_location<0
        parent1_index=index(j);
        break;
    end
    j=j+1;
end
j=1;
while j<=length(sortreuslt)
    parent2_location=parent2_location-sortreuslt(j);
    if parent2_location<0
        parent2_index=index(j);
        break;
    end
    j=j+1;
end

select_parent1=binStr_population(parent1_index,:);
select_parent2=binStr_population(parent2_index,:);

cross_location=randi(4,1,1);

offspring1=strcat(select_parent1(1:cross_location),select_parent2(cross_location+1:end));
offspring2=strcat(select_parent2(1:cross_location),select_parent1(cross_location+1:end));

% Mutation
%% TODO

mutaion_location1=randi(4,1,1);

if offspring1(mutaion_location1)=='0'
    offspring1(mutaion_location1)='1';
else
    offspring1(mutaion_location1)='0';
end

mutaion_location2=randi(4,1,1);
if offspring2(mutaion_location2)=='0'
    offspring2(mutaion_location2)='1';
else
    offspring2(mutaion_location2)='0';
end

population_new=[population_new;offspring1;offspring2];

end




binStr_population=population_new;
population=bin2dec(binStr_population);
fitness_population=objFunc(population);
[max_fitness,max_index]=max(fitness_population);


if max_fitness>bestSoFarFit
bestSoFarFit=max_fitness
bestSoFarSolution=population(max_index);
end
fitness_pop=[fitness_pop,max_fitness];
fitness_gen=[fitness_gen,bestSoFarFit];
solution_gen=[solution_gen,bestSoFarSolution];
nbEval=nbEval+1;


end
figure(1)
plot(1:T,fitness_pop);
title({'Fitness value of the best individual of current population changes with generation';strcat('when population size =',num2str(population_size))});
xlabel('Generation');
ylabel('Current population best fitness value');

figure(2)
plot(1:T,fitness_gen);
title({'Best-so-far fitness value changes with generation';strcat('when population size =',num2str(population_size))});
xlabel('Generation');
ylabel('Best so-far fitness value');



