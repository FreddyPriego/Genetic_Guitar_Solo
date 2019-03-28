%% Genetic replication of matrices
% This script attempts to replicate an matrix via a genetic algorithm.

%% Settings

% Generations
enableMaxGenerations = 1;
maxGenerations = 99999;

% Timeout
enableTimeout = 0;
timeoutMinutes = 10;


% Fitness
enableFitnessBreak = 0;
fitnessBreak = 0.1;

% Stall
enableStallBreak = 0;
stallBreak = 5000;

% Console output
suppressOutput = 0;
modulateOutput = 1;
outputModulation = 100;

% Elitism
enableElitism = 1;
elitismFraction = 0.1;

% Population
populationSize = 100;

startWithBlackCanvas = 1;

paternalProbability = 0.6;

% Mutation (0 = static, 1 = linear, 2 = exponential, 3 = cyclical)
dynamicMutation = 3;

staticMutationProbability = 0.0001;

initialMutationProbability = 0.05;
finalMutationProbability = 0.0005;

finalDynamicGeneration = 30000;

cyclicalWavelengthInGenerations = 150;

% Cooldown
enableCooldown = 1;
cooldownModulation = 1000;
cooldownSeconds = 15;

%% Calculated settings
% Load solo (matrix) to replicate 

solo = [3,1,14;...
    1/2,1,14;...
    1/2,1,15;...
    1/2,1,14;...
    1/2,2,15;...
    1/2,2,17;...
    1/2,2,15;...
    1/2,2,15;...
    1/2,2,14;...
    1/2,2,14;...
    1/2,3,14;...
    1,4,14;...
    1/4,4,12;...
    2,4,12;...
    1/2,1,14;...
    1/2,1,15;...
    1/2,1,14;...
    1/2,2,15;...
    2,2,17;...
    1/2,2,15;...
    1,2,14;...
    1/2,3,14;...
    1/2,4,14;...
    1/2,4,12;...
    1/2,4,11;...
    1/2,4,9;...
    1/2,4,7;...
    2,3,12;...
    1/2,3,11;...
    1/2,4,14;...
    1/2,4,12;...
    1/4,3,11;...
    1/2,3,9;...
    1/4,3,9;...
    1/2,3,7;...
    1/4,3,9;...
    1/4,3,7;...
    1/2,4,9;...
    1/2,3,7;...
    1/2,4,9;...
    1/2,4,11;...
    3,4,12;...
    1/2,1,15;...
    1/2,1,14;...
    1/2,1,12;...
    1/2,2,15;...
    1/2,2,12;...
    1/2,3,12;...
    1,4,12;...
    1/4,4,10;...
    1/2,4,9;...
    1/4,4,10;...
    1/4,4,9;...
    1,4,7]

% Elitism
if enableElitism == 0
    elitismFraction = 0;
end
eliteAmount = floor(populationSize * elitismFraction);
nonEliteIdx = (eliteAmount + 1):populationSize;

% Mutation
eta = (finalMutationProbability - initialMutationProbability) / finalDynamicGeneration;  
alpha = (finalMutationProbability / initialMutationProbability) ^ (1 / finalDynamicGeneration);

% Warnings
if enableMaxGenerations == 0 && enableTimeout == 0 && enableFitnessBreak == 0 && enableStallBreak == 0
    error('At least one method of breaking the loop is required.');
elseif enableMaxGenerations == 0 && enableTimeout == 0 && enableStallBreak == 0
    warning('The loop will only break if the desired fitness is achieved. Achieving the fitness is not guaranteed.');
    executionOverride = input('Continue execution?\n','s');
    if ~isempty(executionOverride) && (executionOverride(1) == 'y' || executionOverride(1) == 'Y')
        fprintf('Execution override successful.\n');
    else
        error('Execution stoped. Please change the parameters or override execution.');
    end
end

if suppressOutput == 0 && modulateOutput == 1
    warning('Evolution output logs will be modulated to every %i generations.',outputModulation);
elseif suppressOutput == 1
    warning('No logs will be generated during the evolution process.');
end

%% Initial population
fprintf('Initializing population... ');

% Allocate memory
theLiving = cell(populationSize,1);
artworkMismatch = zeros(populationSize,1);

solosize = length(solo);
totalelements = solosize*3;
gsolo = zeros(solosize,3);

% Randomize population

for specimen = 1:populationSize
    for n = 1:length(solo)
        t = randi(6);
        if t == 5;
        t = 1/2;
        end
        if t == 6;
        t = 1/4;
        end
    s = randi(6);
    f = randi([6, 15]);
        
    gsolo(n,1) = t;
    gsolo(n,2) = s;
    gsolo(n,3) = f;
    
    end
    
    theLiving{specimen} = gsolo;
    
%     solo-gsolo 
gsolo;
        
    
end

fprintf('Done!\n');

%% Evolution setup
fprintf('Starting evolution process...\n\n');

generation = 1;
savedImageNumber = 1;
bestFitness = 0;

%% Evolution
while true % Breaking conditions found before updating the counter
   % Calculate if there will be console output in this generation
    printToConsole = suppressOutput == 0 && (modulateOutput == 0 || (modulateOutput == 1 && mod(generation,outputModulation) == 0));
    
    % % % Evaluation % % %
    % Generate artworks from current population
    if printToConsole
        fprintf('Drawing generation number %05i... ',generation);
    end
    
    for specimen = 1:populationSize        
                
        % Evaluate mismatch
        artworkMismatch(specimen) = (sum(sum(abs(double(gsolo) - double(solo)))))/totalelements;
    end
         
    if printToConsole
        fprintf('Done!\n');
    end
    
    % Get fitness
    specimenFitness = 1 ./ artworkMismatch;
    [~,bestIdx] = sort(specimenFitness,'descend');
    
    if printToConsole
        fprintf('\tBest fitness in this generation is: %0.8f\n',specimenFitness(bestIdx(1)));
    end
    
    % Check and save (RAM) the all-time best
    if specimenFitness(bestIdx(1)) > bestFitness
        
        % Save the data into memory
        bestFitness = specimenFitness(bestIdx(1));
        bestSpecimen = theLiving{bestIdx(1)};
        bestGeneration = generation;
        
        % Get canvas
        specimen = bestIdx(1);
        
        
               
               
        end
    
    % % % Survival of the fittest % % %
    % Acquire targets
    killed = 0;
    killIdx = false(1,populationSize);
    
    while killed < populationSize / 2
        % Go from unfittest to fittest
        unfitToFit = flip(bestIdx(nonEliteIdx)); % Only the non elite
        
        for s = 1:(populationSize - eliteAmount)
            specimen = unfitToFit(s);
            % Always include probability of survival (also for unfittest, elitism exception)
            if (killIdx(specimen) == false) && (exp(find(specimen == bestIdx,1)/populationSize - 1.1) >= rand)
                % Acquire target
                killIdx(specimen) = true;
                
                % Increase counter and check
                killed = killed + 1;
                if killed >= populationSize / 2
                    break
                end
            end
        end
    end
    
    % TODO: Make this flexible
    % Make 2 clones of the best
    cloneIdx = find(killIdx,2);
    theLiving{cloneIdx(1)} = bestSpecimen;
    theLiving{cloneIdx(2)} = bestSpecimen;
    killIdx(cloneIdx(:)) = false;
    
    % Kill and substitute via reproduction
    replaceWithBaby = find(killIdx);
    for newBaby = 1:length(replaceWithBaby)
        % Only search in the ones not to be killed
        allowedIdx = ~killIdx;
        
        % Get first parent
        firstParentIdx = 0;
        lookingForFirstParent = true;
        while lookingForFirstParent
            % The most fit are the firsts in line
            orderedCandidatesIdx = bestIdx(allowedIdx);
            
            for candidate = 1:length(orderedCandidatesIdx)                
                if rand < paternalProbability
                    lookingForFirstParent = false;
                    firstParentIdx = orderedCandidatesIdx(candidate);
                    allowedIdx(firstParentIdx) = false;
                    break
                end
            end
        end
        
        % Get second parent
        secondParentIdx = 0;
        lookingForSecondParent = true;
        while lookingForSecondParent
            % The most fit are the firsts in line
            orderedCandidatesIdx = bestIdx(allowedIdx);
            
            for candidate = 1:length(orderedCandidatesIdx)
                if rand < paternalProbability
                    lookingForSecondParent = false;
                    secondParentIdx = orderedCandidatesIdx(candidate);
                    break
                end
            end
        end
        
        % Make baby
        for n = 1:length(solo)
        t = randi(6);
        if t == 5;
        t = 1/2;
        end
        if t == 6;
        t = 1/4;
        end
        s = randi(6);
        f = randi([6, 15]);
        
        gsolo(n,1) = t;
        gsolo(n,2) = s;
        gsolo(n,3) = f;
    
        end
        
        firstParent = randi([0, 1]);
        secondParent = ~firstParent;
        theLiving{replaceWithBaby(newBaby)} = firstParent .* theLiving{firstParentIdx} + secondParent .* theLiving{secondParentIdx};
    end
        
    % % % Mutations % % %
    % Stick to a static mutation if dynamic has ended
    if generation > finalDynamicGeneration
        dynamicMutation = 0;
    end

    % Calculate the respective mutation probability
    if dynamicMutation == 1
        mutationProbability = initialMutationProbability - eta * generation;
    elseif dynamicMutation == 2
        mutationProbability = initialMutationProbability * alpha ^ generation;
    elseif dynamicMutation == 3
        normalizedCosine = 0.5 * (1 + cos(2 * pi * generation / cyclicalWavelengthInGenerations));
        mutationProbability = finalMutationProbability + (initialMutationProbability - finalMutationProbability) * normalizedCosine;
    else
        mutationProbability = staticMutationProbability;
    end
    
 %Mutate
     for specimen = 1:populationSize
         mutate = rand(solosize, 3) < mutationProbability;
         newRandomSpecimen = gsolo;
         doNotMutate = ~mutate;
         theLiving{specimen} = doNotMutate .* theLiving{specimen} + mutate .* newRandomSpecimen;
     end
     
     
    % % % Breaking mechanisms % % %
    % Break when achieving max generation
    if (enableMaxGenerations == 1 && generation == maxGenerations)
        break
    end
    
    % Break when achieving fitness
    if (enableFitnessBreak == 1 && bestFitness >= fitnessBreak)
        break
    end
    
    % Break when achieving timeout
    if (enableTimeout == 1 && toc >= timeout)
        break
    end
    
    % Break when stalled progress
    if (enableStallBreak == 1 && generation - bestGeneration == stallBreak)
        break
    end
    
    % Cooldown
    if enableCooldown == 1 && mod(generation,cooldownModulation) == 0
        pause(cooldownSeconds)
    end
    
    % Go to the next generation
    generation = generation + 1;
end

fprintf('Evolution sequence complete. Achieved generation %05i!\n',generation);

bestSpecimen
bestFitness
1/((sum(sum(abs(double(bestSpecimen) - double(solo)))))/totalelements)