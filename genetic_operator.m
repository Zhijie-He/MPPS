function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit,gen,current_gen,VArray)
%% function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit)

[N,~] = size(parent_chromosome);
p = 1;
zoom=0.1;
global VArraysum

% Flags used to set if crossover and mutation were actually performed.
for i = 1 : N
    % With 90 % probability perform crossover 
    % Initialize the children to be null vector.
    child_1 = [];
    child_2 = [];
    % Select the first parent
    parent_1 = round(N*rand(1));
    if parent_1 < 1
        parent_1 = 1;
    end
    % Select the second parent
    parent_2 = round(N*rand(1));
    if parent_2 < 1
        parent_2 = 1;
    end
    parent_4= round(N*rand(1));
    if parent_4 < 1
        parent_4 = 1;
    end
    % Make sure both the parents are not the same. 
    while isequal(parent_1,parent_2)
        parent_2 = round(N*rand(1));
        while isequal(parent_1,parent_4)
            parent_4 = round(N*rand(1));
        end
        if parent_2 < 1
            parent_2 = 1;
        end
        if parent_4 < 1
            parent_4 = 1;
        end
    end
    
    % Get the chromosome information for each randomnly selected
    parent_1 = parent_chromosome(parent_1,:);
    parent_2 = parent_chromosome(parent_2,:);
    parent_4 = parent_chromosome(parent_4,:);
    
    child_1=parent_1(1:VArraysum);
    child_2=parent_2(1:VArraysum);
    
    r1_1=randperm(VArraysum,1);
    r1_2=randperm(VArraysum,1);
    
    while isequal(r1_1,r1_2)
        r1_2=randperm(VArraysum,1);
    end
    
    r1=min(r1_1,r1_2);
    r2=max(r1_1,r1_2);
    c=[];
    for j=r1:r2
        c=[c find(child_2(1:VArraysum)==child_1(j))];
    end
    c=sort(c);
    if size(c,2)~=0
        for j=r1:r2
            temp=child_1(j);
            child_1(j)=child_2(c(j-r1+1));
            child_2(c(j-r1+1))=temp;
        end
    end
    
    for j = 1 : VArraysum
        
        if current_gen>0.65*gen
            u(j) = rand(1);
            if u(j) <= 0.5
                bq(j) = (2*u(j))^(1/(mu+1));
            else
                bq(j) = (1/(2*(1 - u(j))))^(1/(mu+1));
            end
            %Generate the jth element of first child
            child_1(VArraysum+j) = ...
                0.5*(((1 + bq(j))*parent_1(VArraysum+j)) + (1 - bq(j))*parent_2(VArraysum+j));
            % Generate the jth element of second child
            child_2(VArraysum+j) = ...
                0.5*(((1 - bq(j))*parent_1(VArraysum+j)) + (1 + bq(j))*parent_2(VArraysum+j));
        else
            child_1(VArraysum+j)=parent_1(VArraysum+j)+zoom*(parent_2(VArraysum+j)-parent_4(VArraysum+j));
            child_2(VArraysum+j)=parent_4(VArraysum+j)+zoom*(parent_1(VArraysum+j)-parent_2(VArraysum+j));
        end
        % Make sure that the generated element is within the specified
        % decision space else set it to the appropriate extrema.
        if child_1(VArraysum+j) > u_limit(VArraysum+j)
            child_1(VArraysum+j) = u_limit(VArraysum+j);
        elseif child_1(VArraysum+j) < l_limit(VArraysum+j)
            child_1(VArraysum+j) = l_limit(VArraysum+j);
        end
        if child_2(VArraysum+j) > u_limit(VArraysum+j)
            child_2(VArraysum+j) = u_limit(VArraysum+j);
        elseif child_2(VArraysum+j) < l_limit(VArraysum+j)
            child_2(VArraysum+j) = l_limit(VArraysum+j);
        end
    end
    
    child_1(VArraysum*2+1:VArraysum*3)=parent_1(VArraysum*2+1:VArraysum*3);
    child_2(VArraysum*2+1:VArraysum*3)=parent_2(VArraysum*2+1:VArraysum*3);
    CRpoint=randperm(VArraysum,1);
    temp=child_1(VArraysum*2+CRpoint:VArraysum*3);
    child_1(VArraysum*2+CRpoint:VArraysum*3)=child_2(VArraysum*2+CRpoint:VArraysum*3);
    child_2(VArraysum*2+CRpoint:VArraysum*3)=temp;
    
    % Evaluate the objective function for the offsprings and as before
    % concatenate the offspring chromosome with objective value.

    [child_1,child_1(:,V + 1: M + V)] = evaluate_objective(child_1, M, VArray);
    [child_2,child_2(:,V + 1: M + V)] = evaluate_objective(child_2, M, VArray);
    % Set the crossover flag. When crossover is performed two children
    % are generate, while when mutation is performed only only child is
    % generated.
    
    % With 10 % probability perform mutation. Mutation is based on
    % polynomial mutation.
    % Select at random the parent.
    parent_3 = round(N*rand(1));
    if parent_3 < 1
        parent_3 = 1;
    end
    % Get the chromosome information for the randomnly selected parent.
    child_3 = parent_chromosome(parent_3,:);
    
    mCnt = 0;
    k=0;
    m=[];
    Pm=0.01;
    while mCnt<=1
        k=k+1;
        if rand(1)<Pm
            mCnt=mCnt+1;
            m=[m k];
        end
    end
    k1=mod(m(1),VArraysum)+1;
    k2=mod(m(2),VArraysum)+1;
    temp=child_3(k1);
    child_3(k1)=child_3(k2);
    child_3(k2)=temp;
    
    k1=mod(m(1),3)+1;
    k2=mod(m(2),3)+1;
    temp=child_3(VArraysum*2+k1);
    child_3(VArraysum*2+k1)=child_3(VArraysum*2+k2);
    child_3(VArraysum*2+k2)=temp;
    
    
    for j = 1 : VArraysum
        r(j) = rand(1);
        if r(j) < 0.5
            delta(j) = (2*r(j))^(1/(mum+1)) - 1;
        else
            delta(j) = 1 - (2*(1 - r(j)))^(1/(mum+1));
        end
        % Generate the corresponding child element.
        child_3(VArraysum+j) = child_3(VArraysum+j) + delta(j);
        % Make sre that the generated element is within the decision
        % space.
        if child_3(VArraysum+j) > u_limit(VArraysum+j)
            child_3(VArraysum+j) = u_limit(VArraysum+j);
        elseif child_3(VArraysum+j) < l_limit(VArraysum+j)
            child_3(VArraysum+j) = l_limit(VArraysum+j);
        end
    end
    % Evaluate the objective function for the offspring and as before
    % concatenate the offspring chromosome with objective value.
    [child_3,child_3(V + 1: M + V)] = evaluate_objective(child_3, M, VArray);
    % Set the mutation flag
    % Keep proper count and appropriately fill the child variable with all
    % the generated children for the particular generation.
    child(p,:) = child_1;
    child(p+1,:) = child_2;
    p = p + 2;
    child(p,:) = child_3(1 : M + V);
    p = p + 1;
end
f = child;
