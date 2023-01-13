function f = initialize_variables(N, M, V,VArray)

%% function f = initialize_variables(N, M, V,VArray)
%{
   N : The size of population
   M : The number of objective functions
   V : The number of decision variables
   VArray : The array contains the number of tasks for each project
 %}

%% Initialize each chromosome
K = M + V;  
global VArraysum;

f(N,V)=single(0);
for i = 1 : N 
    %  Random generate the importance of each task
    f(i,1:VArraysum) = randperm(VArraysum);
    
    % generate the coefficient of cooperation to each task
    f(i,VArraysum+1:VArraysum*2) = rand(1,VArraysum); % the coefficient of cooperation; random generated (0-1)
    if i==1
        f(i,VArraysum+1:VArraysum*2) = zeros(1,VArraysum);
    elseif i==2
        f(i,VArraysum+1:VArraysum*2) = ones(1,VArraysum);
    elseif i==3
        f(i,VArraysum+1:VArraysum*2) = ones(1,VArraysum)*0.5;
    end
    
    % randomly allocate one partner to each task
    for j = 1 : VArraysum
        f(i, VArraysum*2+j) = randperm(3,1);  
    end
       
    % evaluate initial pop 
    [f(i, :), f(i, V+1:K)] = evaluate_objective(f(i,:), M, VArray);
end

