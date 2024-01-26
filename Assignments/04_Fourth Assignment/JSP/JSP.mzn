include "globals.mzn";

int: M;     % Number of machines = number of tasks
int: J;     % Number of jobs

set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;

array[JOB,TASK] of MACH: machine;     % machines for tasks
array[JOB,MACH] of int: duration;     % task durations on machines

int: maximum_duration = sum(j in JOB, i in MACH)(duration[j,i]);
array[JOB,TASK] of var 0..maximum_duration: start;

% ------ dummyTask ------
var 0..maximum_duration: dummyTask;

% ------ Precedence constraint ------
constraint forall(job in JOB, i in 1..M-1)((start[job, i] + duration[job, machine[job, i]]) <= start[job, i+1]);

% dummyTusk must be the last task.
constraint forall(job in JOB)(start[job, M] + duration[job, machine[job, M]] <= dummyTask); 
                                                                                                         
% ------ Disjunctive constraint ------
constraint forall(mach in MACH)(disjunctive([start[job, i] | job in JOB, i in TASK where machine[job, i] == mach ], duration[..,mach]));

% ------ Default Search ------
% solve minimize dummyTask;

% ------ Smallest ------
solve :: int_search(start, smallest, indomain_min) minimize dummyTask;

% Output makespan
output ["dummyTask: \(dummyTask)"] ++ ["\nStart times:\n"] ++ [show(start)];
