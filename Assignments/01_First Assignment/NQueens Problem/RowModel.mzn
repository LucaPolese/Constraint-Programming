  % Row model
include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: rows; % Variables for queens on the rows

% Column attack constraints using the alldifferent constraint.
% Append ::domain to the end.  
constraint alldifferent(rows)::domain;
constraint forall(i,j in 1..n where i <j)(abs(rows[i]-rows[j]) != abs(i-j));

% Diagonal attack constraints

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;