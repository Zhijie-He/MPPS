function [x,f] = evaluate_objective(x,M,VArray)

%% function f = evaluate_objective(x, M, VArray)
%{
   x : one sample of population
   M : The number of objective functions
   VArray : The array contains the number of tasks for each project
 %}

global VArraysum;
global indegree;
global self;
global candidate;
global R;

% deal with the cooperation coefficient 
for i = 1 : VArraysum
    if candidate(i, x(VArraysum*2+i),1) == -1  % -1 means this task cannot be assigned to outsourcing
        x(VArraysum + i)=0; % we set coefficient of cooperation to 0
    end
    if x(VArraysum + i) < 0.2 % if the coefficient of cooperation is too low, it's not worth to cooperate
        x(VArraysum + i) = 0;
    end
    if x(VArraysum + i) > 0.8 % % if the coefficient of cooperation is too high, let outsource do everything
        x(VArraysum + i) = 1;
    end
end

f = zeros(1,M);
if M == 2
    % Objective function one: Calculate the expected project time
    Alltime = TuoPu29F3(x(1 : VArraysum), x(VArraysum+1 : VArraysum*2), x(VArraysum*2+1 : VArraysum*3), self, candidate, indegree, R, false);
    f(1) = Alltime;
else
    [~, gante_tu] = TuoPu29F3(x(1:VArraysum), x(VArraysum+1:VArraysum*2), x(VArraysum*2+1:VArraysum*3), self,candidate, indegree, R, false);
    f(1) = max(gante_tu(1:VArray(1), 4)); % the time of finishing project A
    f(2) = max(gante_tu(VArray(1):VArraysum, 4));% the time of finishing project B
end

% The last Objective function : The cost of project
Costsum=0;
for i = 1 : VArraysum
    Costsum = Costsum + ((1 - x(VArraysum+i))*self(i,1) + x(VArraysum+i) * candidate(i,x(VArraysum*2 + i),1));
end
f(M) = Costsum;

%% Check for error
if length(f) ~= M 
    error('The number of decision variables does not match you previous input. Kindly check your objective function');
end