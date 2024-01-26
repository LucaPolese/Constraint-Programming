include "globals.mzn";

% The Sequence Puzzle
int: n;
array[1..n] of var 0..n-1: x;

% -------- Global Constraint -------- 
constraint global_cardinality(x, [i | i in 0..n-1], x);

% -------- First Implied Constraint --------
constraint sum(i in 1..n)(x[i]) == n;

% -------- Second Implied Constraint --------
constraint sum(i in 1..n)(x[i] * i - 1) == n;

solve satisfy;

output [ "x = \(x);\n" ] ;