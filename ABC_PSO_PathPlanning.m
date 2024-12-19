%% ABC + PSO Path Planning Problem
% Here, system tries to find the most optimal path between starting point
% and destination point with aid of Artificial Bee Colony (ABC) algorithm
% and Particle Swarm Optimization algorithm combined. It is good strategy
% in robotics path finding. In each run new obstacles in new positions
% defines and a curved line tries to find the best path. Run multiple times
% to find the best result. 
% Hope this code help you :)

%% Cleaning The Stage
clc;
clear;
warning('off');

%% Start ABC + PSO Optimal Path Finder
model=Basics();
model.n=6;  % number of Handle Points
CostFunction=@(x) Cost(x,model);    % Cost Function
nVar=model.n;       % Number of Decision Variables
VarSize=[1 nVar];   % Size of Decision Variables Matrix
VarMin.x=model.xmin;           % Lower Bound of Variables
VarMax.x=model.xmax;           % Upper Bound of Variables
VarMin.y=model.ymin;           % Lower Bound of Variables
VarMax.y=model.ymax;           % Upper Bound of Variables

%% PSO + ABC Parameters
MaxIt=150;          % Maximum Number of Iterations
nPop=20;           % Population Size (Swarm Size)
w=1;                % Inertia Weight
wdamp=0.98;         % Inertia Weight Damping Ratio
c1=1.5;             % Personal Learning Coefficient
c2=1.5;             % Global Learning Coefficient
nOnlooker = nPop;         % Number of Onlooker Bees
L = round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit)
a = 1;
alpha=0.1;
VelMax.x=alpha*(VarMax.x-VarMin.x);    % Maximum Velocity
VelMin.x=-VelMax.x;                    % Minimum Velocity
VelMax.y=alpha*(VarMax.y-VarMin.y);    % Maximum Velocity
VelMin.y=-VelMax.y;                    % Minimum Velocity

%% Initialization PSO + ABC
% Create Empty Particle Structure
empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Sol=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
empty_particle.Best.Sol=[];
% Empty Bee Structure
empty_bee.Position = [];
empty_bee.Cost = [];
% Initialize Global Best
GlobalBest.Cost=inf;
% Initialize Population Array
pop = repmat(empty_bee, nPop, 1);
bee = repmat(empty_bee, nPop, 1);
% Initialize Best Solution Ever Found
BestSol.Cost = inf;
GlobalBest.Cost=inf;
% Create Particles Matrix
particle=repmat(empty_particle,nPop,1);
% Initialization Loop
for i=1:nPop
% Initialize Position
if i > 1
particle(i).Position=CRSolution(model);
else
% Straight line from source to destination
xx = linspace(model.xs, model.xt, model.n+2);
yy = linspace(model.ys, model.yt, model.n+2);
particle(i).Position.x = xx(2:end-1);
particle(i).Position.y = yy(2:end-1);
end
% Initialize Velocity
particle(i).Velocity.x=zeros(VarSize);
particle(i).Velocity.y=zeros(VarSize);
% Evaluation
[particle(i).Cost, particle(i).Sol]=CostFunction(particle(i).Position);
% Update Personal Best
particle(i).Best.Position=particle(i).Position;
particle(i).Best.Cost=particle(i).Cost;
particle(i).Best.Sol=particle(i).Sol;
% Update Global Best
if particle(i).Best.Cost<GlobalBest.Cost
GlobalBest=particle(i).Best;
end
end
% Initialization Loop
for i=1:nPop
% Initialize Position
if i > 1
pop(i).Position=CRSolution(model);
else
% Straight line from source to destination
xx = linspace(model.xs, model.xt, model.n+2);
yy = linspace(model.ys, model.yt, model.n+2);
pop(i).Position.x = xx(2:end-1);
pop(i).Position.y = yy(2:end-1);
end
% Initialize Velocity
pop(i).Velocity.x=zeros(VarSize);
pop(i).Velocity.y=zeros(VarSize);
% Evaluation
[pop(i).Cost, pop(i).Sol]=CostFunction(pop(i).Position);
% Update Personal Best
pop(i).Best.Position=pop(i).Position;
pop(i).Best.Cost=pop(i).Cost;
pop(i).Best.Sol=pop(i).Sol;
% Update Global Best
if pop(i).Best.Cost<GlobalBest.Cost
GlobalBest=pop(i).Best;
end
end
% Abandonment Counter
C = zeros(nPop, 1);
% Array to Hold Best Cost Values at Each Iteration
BestCost=zeros(MaxIt,1);

%% PSO + ABC Main Body Code
for it=1:MaxIt
% Recruited Bees
for i = 1:nPop
% Choose k randomly, not equal to i
K = [1:i-1 i+1:nPop];
k = K(randi([1 numel(K)]));
% Define Acceleration Coeff.
phi = a*unifrnd(-1, +1, VarSize);
% New Bee Position
newbee.Position = pop(i).Position.x+phi.*(pop(i).Position.x-pop(k).Position.x);
% Apply Bounds
newbee.Position = max(newbee.Position, VarMin.x);
newbee.Position = min(newbee.Position, VarMax.x);
% Evaluation
newbee.Position = newbee.Position*rand;
newbee.Cost = pop(i).Cost*rand;
% Calculate Fitness Values and Selection Probabilities
F = zeros(nPop, 1);
MeanCost = mean([pop(i).Cost]);
for i = 1:nPop
F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
end
P = F/sum(F);
% Onlooker Bees
for m = 1:nOnlooker
% Select Source Site
i = RWSelection(P);
% Choose k randomly, not equal to i
K = [1:i-1 i+1:nPop];
k = K(randi([1 numel(K)]));
% Define Acceleration Coeff.
phi = a*unifrnd(-1, +1, VarSize);
% New Bee Position
newbee.Position = pop(i).Position.y+phi.*(pop(i).Position.y-pop(k).Position.y);
% Apply Bounds
newbee.Position = max(newbee.Position, VarMin.y);
newbee.Position = min(newbee.Position, VarMax.y);
% Evaluation
newbee.Position = pop(i).Cost*rand;
newbee.Cost = pop(i).Cost*rand;
end
GlobalBestbee=pop(i).Best;
% Update Best Cost Ever Found
BestCostbee(it)=GlobalBest.Cost;
BestCostbee=BestCostbee';
% Scout Bees
for i = 1:nPop
if C(i) >= L
pop(i).Position = unifrnd(VarMin, VarMax, VarSize);
pop(i).Cost = CostFunction(pop(i).Position);
C(i) = 0;
end
end
% Update Best Solution Ever Found
for i = 1:nPop
if pop(i).Cost <= BestSol.Cost
BestSol = pop(i);
end
end
end
for i=1:nPop
% Update Velocity
particle(i).Velocity.x = w*particle(i).Velocity.x ...
+ c1*rand(VarSize).*(particle(i).Best.Position.x-particle(i).Position.x) ...
+ c2*rand(VarSize).*(GlobalBest.Position.x-particle(i).Position.x);
% Update Velocity Bounds
particle(i).Velocity.x = max(particle(i).Velocity.x,VelMin.x);
particle(i).Velocity.x = min(particle(i).Velocity.x,VelMax.x);
% Update Position
particle(i).Position.x = particle(i).Position.x + particle(i).Velocity.x;
% Velocity Mirroring
OutOfTheRange=(particle(i).Position.x<VarMin.x | particle(i).Position.x>VarMax.x);
particle(i).Velocity.x(OutOfTheRange)=-particle(i).Velocity.x(OutOfTheRange);
% Update Position Bounds
particle(i).Position.x = max(particle(i).Position.x,VarMin.x);
particle(i).Position.x = min(particle(i).Position.x,VarMax.x);
% Update Velocity
particle(i).Velocity.y = w*particle(i).Velocity.y ...
+ c1*rand(VarSize).*(particle(i).Best.Position.y-particle(i).Position.y) ...
+ c2*rand(VarSize).*(GlobalBest.Position.y-particle(i).Position.y);
% Update Velocity Bounds
particle(i).Velocity.y = max(particle(i).Velocity.y,VelMin.y);
particle(i).Velocity.y = min(particle(i).Velocity.y,VelMax.y);
% Update Position
particle(i).Position.y = particle(i).Position.y + particle(i).Velocity.y;
% Velocity Mirroring
OutOfTheRange=(particle(i).Position.y<VarMin.y | particle(i).Position.y>VarMax.y);
particle(i).Velocity.y(OutOfTheRange)=-particle(i).Velocity.y(OutOfTheRange);
% Update Position Bounds
particle(i).Position.y = max(particle(i).Position.y,VarMin.y);
particle(i).Position.y = min(particle(i).Position.y,VarMax.y);
% Evaluation
[particle(i).Cost, particle(i).Sol]=CostFunction(particle(i).Position);
% Update Personal Best
if particle(i).Cost<particle(i).Best.Cost
particle(i).Best.Position=particle(i).Position;
particle(i).Best.Cost=particle(i).Cost;
particle(i).Best.Sol=particle(i).Sol;
% Update Global Best
if particle(i).Best.Cost<GlobalBest.Cost
GlobalBest=particle(i).Best;
end
end
end
% Update Best Cost Ever Found
GlobalBest.Cost=GlobalBest.Cost+ GlobalBestbee.Cost;
BestCost(it)=GlobalBest.Cost;
% Inertia Weight Damping
w=w*wdamp;
% Show Iteration Information
if GlobalBest.Sol.IsFeasible
Flag=' o';
else
Flag=[', Violation = ' num2str(GlobalBest.Sol.Violation)];
end
disp(['In Iteration Number ' num2str(it) ':ABC+PSO Fittest Value Is = ' num2str(BestCost(it)) Flag]);

% Plot Solution
figure(1);
Plotting(GlobalBest.Sol,model);
pause(0.01);
end
%% Plot Train Stage
figure;
plot(sort(BestCost,'descend'),'r.','LineWidth',3);
title ('ABC + PSO Training');
xlabel('Itr');
ylabel('ABC+PSO Fittest Value');
grid on;



