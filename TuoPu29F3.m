function [Alltime,gante_tu] = TuoPu29F3(x, index, part, self, candidate, indegree, R, print_time)
%{
   x : the priority array of each task
   index : the cooperation coefficient 
   part : The array of assigned partners number
   self : the cost array of insourcing
   candidate : the cost array of outsourcing
   R : the array resources number 
   flag_F2 : if print enter and exit time
%}

% Concept: Topological sorting
global VArraysum;
global s;

% Priority
visit = zeros(1, VArraysum);

answer = [];
result_max=[];

gante_tu(1: VArraysum, 1) = 1 : VArraysum;
gante_tu(1: VArraysum, 2) = 1 : VArraysum;

% calculate the cost and time for each task 
for i = 1 : VArraysum
    self(i,1)= (1-index(i)) * self(i,1) + index(i) * candidate(i, part(i), 1);
    self(i,2)= (1-index(i)) * self(i,2) + index(i) * candidate(i, part(i), 2);
end

used = zeros(1,VArraysum);
Alltime = 0;

wait = []; % waiting list
exe = []; % executing list
flag_1 = 0; % flag_1 standards for the number of tasks that have finished

while flag_1 ~= VArraysum
    flag_1 = 0;
    result_max = []; % the tasks that are ready to execute
    for k = 1 : VArraysum
        % if task k indegree is 0 which means it can be executed 
        % if task k hasn't been visited and used
        % add task k to result array
        if ~indegree(k) && ~visit(k) && ~used(k)
            result_max = [result_max k];
        end
    end
    % get the len of result array
    L = size(result_max,2);
    
    if L == 1 && size(exe,2) == 0
        %R(self(result_max(1)).resource) = R(self(result_max(1)).resource)-1;
        %R(self(result_max(1)).resource) = R(self(result_max(1)).resource)+1;
        p = result_max(1);
        visit(p) = 1;
        answer = [answer p];
        enter_time = Alltime;
        
        if print_time
        fprintf('time=%d, %d enter\n',enter_time,p);
        end
        
        gante_tu(p,3) = enter_time;
        % get time for task result_max(1)
        Alltime = Alltime + self(result_max(1),2);
        quit_time = Alltime;
        
        if print_time
        fprintf('time=%d, %d exit\n',quit_time,p);
        end
        
        gante_tu(p,4) = quit_time;
        % delelte nodes k in graph
        for j = 1 : VArraysum
            if s(p,j)
                indegree(j) = indegree(j) - 1;
            end
        end
    elseif L + size(exe,2) >= 1
        [~,index] = sort(x(result_max(1:end)));
        
        if  size(result_max,2) ~= 0
            for u = 0 : L-1
                p = result_max(index(end-u));
                % if current has enough resources to execute p
                if  R(self(p,3)) >= self(p,4)
                    % remove the resources that have been assigned
                    R(self(p,3)) = R(self(p,3)) - self(p,4);
                    % put p into executing list
                    exe = [exe p];
                    used(p) = 1;
                    enter_time = Alltime;
                    if print_time 
                    fprintf('time=%d, %d enter\n',enter_time,p);
                    end
                    gante_tu(p,3) = enter_time;
                else
                    % put into waiting list
                    wait = [wait p];
                end
            end
        end
        
        % execute
        time = [];
        % get the left time for tasks in executing list
        for u = 1 : size(exe,2)
            time = [time self(exe(u),2)];
        end
        % get the min left time of tasks in executing list
        [mintime,~] = min(time);
        c = [];
        for u = 1 : size(exe,2)
            self(exe(u),2) = self(exe(u),2) - mintime;
            if self(exe(u),2) == 0
                c = [c u];
                visit(exe(u)) = 1;
                answer = [answer exe(u)];
                % release resources
                R(self(exe(u),3)) = R(self(exe(u),3)) + self(exe(u),4);
                for j = 1 : VArraysum
                    if s(exe(u),j)
                        % remove task exe(u) in graph
                        indegree(j) = indegree(j) - 1;
                    end
                end
            end
        end
        Alltime = Alltime + mintime;
        for i = 1:size(c,2)
            quit_time = Alltime;
            if print_time
            fprintf('time=%d, %d exit\n',quit_time,exe(c(i)));
            end
            gante_tu(exe(c(i)),4) = quit_time;
        end
        % remove tasks from executing list
        exe(c)=[];
    end
    
    for n = 1:VArraysum
        if visit(n) == 1
            flag_1 = flag_1 + 1;
        end
    end
    
end
end





