include "globals.mzn";

% -------- A set of tasks with durations and resource requirements. --------
int: n_tasks;                         % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration;        % Task durations

% -------- A set of cumulative resources --------
int: n_res;                           % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L;           % Resource capacities
array[RESOURCES,TASKS] of int: req;   % Resource requirements of tasks

% -------- Precendence constraints between some tasks --------
int: p;                               % Number of precedence relations
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre;       % Precedence relations

% -------- Maximum duration --------
int: maximum_duration = sum(duration);  
array[TASKS] of var 0..maximum_duration: start;

var int: makespan = max(task in TASKS)(start[task] + duration[task]); % makespan

% -------- Precedence constraint --------
constraint forall(job in PREC)(start[pre[job, 2]] >= start[pre[job, 1]] + duration[pre[job, 1]])::domain;

% -------- Cumulative constraint --------
constraint forall(resource in RESOURCES)(cumulative(start, duration, req[resource, TASKS], L[resource]))::domain;

% ------ Default Search ------
solve minimize makespan;

% ------ Indomain Min ------
% solve :: int_search(start, smallest, indomain_min) minimize makespan ;


output ["makespan=\(makespan)"];