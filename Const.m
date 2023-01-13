function  VArray = Const()

%Project Array; Store the number of tasks for each Project
VArray(1)=16;
VArray(2)=13;

% The total number of tasks
global VArraysum;
VArraysum = sum(VArray);

% Resources array
global R;

R(1)=4;
R(2)=5;
R(3)=6;

% Adjacency matrix
global s ;
s = zeros(VArraysum,VArraysum);

%% Project A 
s(1,2) = 1;
s(2,3) = 1;
s(3,4) = 1;
s(3,5) = 1;
s(3,6) = 1;
s(4,7) = 1;
s(4,15) = 1;
s(5,8) = 1;
s(6,9) = 1;
s(7,9) = 1;
s(8,10) = 1;
s(9,11) = 1;
s(9,12) = 1;
s(10,13) = 1;
s(11,16) = 1;
s(12,14) = 1;
s(15,10) = 1;
s(16,14) = 1;

%% Project B
s(17,18) = 1;
s(18,19) = 1;
s(18,20) = 1;
s(18,21) = 1;
s(19,22) = 1;
s(19,23) = 1;
s(19,24) = 1;
s(20,22) = 1;
s(20,23) = 1;
s(20,24) = 1;
s(21,25) = 1;
s(22,23) = 1;
s(24,23) = 1;
s(23,26) = 1;
s(25,27) = 1;
s(26,27) = 1;
s(27,28) = 1;
s(28,29) = 1;


% Graph nodes indegree 
global indegree;
indegree = zeros(1,VArraysum);
for i= 1: VArraysum
    indegree(i)=sum(s(:,i));
end

% the cost of insourcing
global self;
% the cost of outsourcing
global candidate;

%% Project A cost
% E.g [400 5 1 3]
%[the cost of insourcing; 400
% the time of insourcing; 5
% the resource used; 1
% the number of resources used;]3
self(1,:)=[400 5 1 3];
self(2,:) = [350 6 2 4];
self(3,:) = [370 5 1 3];
self(4,:) = [800 8 3 4];
self(5,:) = [250 7 2 2];
self(6,:) = [550 4 1 4];
self(7,:) = [900 6 1 3];
self(8,:) = [460 5 3 2];
self(9,:) = [550 9 2 3];
self(10,:) = [370 6 1 1];
self(11,:) = [410 5 2 3];
self(12,:) = [500 4 2 4];
self(13,:) = [380 5 3 5];
self(14,:) = [900 6 1 3];
self(15,:) = [300 6 2 2];
self(16,:) = [400 7 3 4];

%[the cost of outsourcing; 450
% the time of outsourcing;] 4
% for each task, it has 1-3 candidates. if the value of cose is -1, means
% it doesn't have this candidate.
candidate(1,1,:) = [450 4];
candidate(1,2,:) = [500 3];
candidate(1,3,:) = [550 2];

candidate(2,1,:) = [400 6];
candidate(2,2,:) = [380 7];
candidate(2,3,:) = [450 4];

candidate(3,1,:) = [460 3];
candidate(3,2,:) = [400 4];
candidate(3,3,:) = [390 6];

candidate(4,1,:) = [900 4];
candidate(4,2,:) = [900 5];
candidate(4,3,:) = [860 7];

candidate(5,1,:) = [340 5];
candidate(5,2,:) = [400 4];
candidate(5,3,:) = [300 5];

candidate(6,1,:) = [600 4];
candidate(6,2,:) = [800 2];
candidate(6,3,:) = [700 3];

candidate(7,1,:) = [1100 9];
candidate(7,2,:) = [1200 5];
candidate(7,3,:) = [1500 4];

candidate(8,1,:) = [800 2];
candidate(8,2,:) = [600 4];
candidate(8,3,:) = [500 5];

candidate(9,1,:) = [650 7];
candidate(9,2,:) = [700 6];
candidate(9,3,:) = [600 8];

candidate(10,1,:) = [400 6];
candidate(10,2,:) = [460 3];
candidate(10,3,:) = [420 5];

candidate(11,1,:) = [450 6];
candidate(11,2,:) = [550 4];
candidate(11,3,:) = [500 5];

candidate(12,1,:) = [650 6];
candidate(12,2,:) = [800 4];
candidate(12,3,:) = [700 5];

candidate(13,1,:) = [400 6];
candidate(13,2,:) = [460 5];
candidate(13,3,:) = [700 3];

candidate(14,1,:) = [1100 5];
candidate(14,2,:) = [1300 4];
candidate(14,3,:) = [950 8];

%task 15 and 16 cannot be outsourced
candidate(15,1,:) = [-1 5];
candidate(15,2,:) = [-1 5];
candidate(15,3,:) = [-1 5];

candidate(16,1,:) = [-1 5];
candidate(16,2,:) = [-1 5];
candidate(16,3,:) = [-1 5];


%% Project B cost

self(17,:) = [400 6 1 3];
self(18,:) = [350 7 2 4];
self(19,:) = [370 8 3 5];
self(20,:) = [800 8 3 3];
self(21,:) = [250 6 2 3];
self(22,:) = [550 7 1 4];
self(23,:) = [900 8 1 3];
self(24,:) = [460 5 3 3];
self(25,:) = [550 7 2 4];
self(26,:) = [370 8 1 2];
self(27,:) = [410 5 2 3];
self(28,:) = [500 4 2 4];
self(29,:) = [380 7 3 3];

candidate(17,1,:) = [-1 6];
candidate(17,2,:) = [-1 5];
candidate(17,3,:) = [-1 3];

candidate(18,1,:) = [400 6];
candidate(18,2,:) = [380 7];
candidate(18,3,:) = [450 4];

candidate(19,1,:) = [460 3];
candidate(19,2,:) = [400 4];
candidate(19,3,:) = [390 6];

candidate(20,1,:) = [900 4];
candidate(20,2,:) = [900 5];
candidate(20,3,:) = [860 7];

candidate(21,1,:) = [340 5];
candidate(21,2,:) = [400 4];
candidate(21,3,:) = [300 5];

candidate(22,1,:) = [600 4];
candidate(22,2,:) = [800 2];
candidate(22,3,:) = [700 3];

candidate(23,1,:) = [1100 4];
candidate(23,2,:) = [1200 5];
candidate(23,3,:) = [1500 4];

candidate(24,1,:) = [800 2];
candidate(24,2,:) = [600 4];
candidate(24,3,:) = [500 5];

candidate(25,1,:) = [650 7];
candidate(25,2,:) = [700 6];
candidate(25,3,:) = [600 8];

candidate(26,1,:) = [400 6];
candidate(26,2,:) = [460 3];
candidate(26,3,:) = [420 5];

% Project 27,28,29 cannot be outsourced
candidate(27,1,:) = [-1 6];
candidate(27,2,:) = [-1 5];
candidate(27,3,:) = [-1 3];

candidate(28,1,:) = [-1 6];
candidate(28,2,:) = [-1 5];
candidate(28,3,:) = [-1 3];

candidate(29,1,:) = [-1 6];
candidate(29,2,:) = [-1 5];
candidate(29,3,:) = [-1 3];
end
