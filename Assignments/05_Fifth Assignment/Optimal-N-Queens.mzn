include "alldifferent.mzn";
include "gecode.mzn";

% Number of Queens
int: n; 

% Variables for queens on the rows 
array[1..n] of var 1..n: q;

constraint alldifferent(q)::domain;

% Column attack constraint
constraint alldifferent([q[i] + i | i in 1..n])::domain;

% Diagonal attack constraint
constraint alldifferent([q[i]-i | i in 1..n])::domain;

% Minimize the total distance of the queens to the main diagonal
var int: obj = sum(i in 1..n)(abs(q[i] - i));

% ------- Default search -------
% solve minimize obj;

% ------- domWdeg - random value -------
solve:: int_search(q, dom_w_deg, indomain_random) minimize obj;

% ------- domWdeg - random value + restarting -------
%solve :: int_search(q, dom_w_deg, indomain_random) :: restart_luby(250) minimize obj;

% ------- domWdeg - random value + restarting + lns -------
% solve :: int_search(q, dom_w_deg, indomain_random) :: restart_luby(250) :: relax_and_reconstruct(q, 85) minimize obj;