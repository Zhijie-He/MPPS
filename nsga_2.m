function nsga_2(pop,gen)
if nargin < 2
    error('NSGA-II: Please enter the population size and number of generations as input arguments.');
end
if isnumeric(pop) == 0 || isnumeric(gen) == 0
    error('Both input arguments pop and gen should be integer datatype');
end
if pop < 20
    error('Minimum population for running this function is 20');
end
if gen < 5
    error('Minimum number of generations is 5');
end
pop = round(pop);
gen = round(gen);

% Get const values
VArray = Const();
global R;
global VArraysum;
global indegree;
global self;
global candidate;

%% Objective Function
[M, V, min_range, max_range] = objective_description_function();

%% Initialize the population
chromosome = initialize_variables(pop, M, V, VArray);

%% Sort the initialized population
chromosome = non_domination_sort_mod(chromosome, M, V);

%% Start the evolution process
for i = 1 : gen
    pool = round(pop/2);
    tour = 2;
    parent_chromosome = tournament_selection(chromosome, pool, tour);
    mu = 20;
    mum = 20;
    offspring_chromosome = ...
        genetic_operator(parent_chromosome, ...
        M, V, mu, mum, min_range, max_range,gen,i,VArray);
    [main_pop,~] = size(chromosome);
    [offspring_pop,~] = size(offspring_chromosome);
    % intermediate_chromosome is a concatenation of current population and the offspring population.
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = ...
        offspring_chromosome;
    
    % Non-domination-sort of intermediate population
    intermediate_chromosome = ...
        non_domination_sort_mod(intermediate_chromosome, M, V);
    % Perform Selection
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop);
    
    fprintf('%d generations completed\n',i);
    if M == 2
        plot(chromosome(:,V + 1),chromosome(:,V + 2),'*');
        xlabel('Project time');
        ylabel('Project cost');
        xlim([30 100]);
        ylim([7000 20000]);
        title('Multi-objective pareto diagram based on key resources');
        pause(0.01);
    elseif M ==3
        %plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3),'*');
        %plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3),'rd','Markersize',10,'LineWidth',2);
        title('Multi-objective pareto diagram based on key resources');
        clf % clear figure
        A = [chromosome(:,V + 1) chromosome(:,V + 2) chromosome(:,V + 3)];
        A = unique(A,'rows');
        x = A(:,1);y = A(:,2);z = A(:,3);
        [X,Y,Z] = griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');%插值
        mesh(X,Y,Z),hold on,scatter3(x,y,z,'filled');
        xlim([30 120]);
        ylim([50 120]);
        zlim([10000 18000]);
        pause(0.03);
    end
end
%% Result
save solution.txt chromosome -ASCII

%% Visualize
if M == 2
    figure
    subplot(1,2,1);
    plot(chromosome(:,V + 1),chromosome(:,V + 2),'*');
    legend('Pareto Algorithm');
    xlabel('Project time');
    ylabel('Project cost');
    title('Multi-objective pareto diagram based on key resources');
    
    subplot(1,2,2);
    hold on;
    A=[chromosome(:,V + 1) chromosome(:,V + 2)];
    A=unique(A,'rows');%可以删除A的重复行
    x=A(:,1);y=A(:,2);
    p = polyfit(x,y,7);
    f = polyval(p,x);
    plot(x,y,'*',x,f,'-')
    xlabel('Project time');
    ylabel('Project cost');
    title('Multi-objective pareto diagram based on key resources');
    legend('paroto algorithm','curve fitting');
	
elseif M ==3
    clf
    plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3),'*');
    figure
    A = [chromosome(:,V + 1) chromosome(:,V + 2) chromosome(:,V + 3)];
    A = unique(A,'rows'); % delete duplicate rows
    x = A(:,1);y = A(:,2);z = A(:,3);
    [X,Y,Z] = griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');%插值
    mesh(X,Y,Z),hold on,scatter3(x,y,z,'filled');% draw mesh graph and scatter points
    % 3D rotation
    axis vis3d
    for i=1:20
        pause(0.2);
        camorbit(10,0)
        drawnow
    end
end

figure(2)
test_x = chromosome(1, 1:VArraysum);
test_index = chromosome(1, VArraysum+1:VArraysum*2);
test_part = chromosome(1, VArraysum*2+1:VArraysum*3);
[~,gante_tu] = TuoPu29F3(test_x, test_index, test_part, self, candidate, indegree, R, true);
fprintf('The above is a time sequence with a total time of %d days\nThe Gantt chart is shown in the figure\n',max(gante_tu(:,4)));
gante(gante_tu, VArray);
end