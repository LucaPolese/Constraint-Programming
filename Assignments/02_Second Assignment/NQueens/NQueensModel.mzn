% Alldifferent model
include "alldifferent.mzn";

int: n; % Number of queens
array [1..n] of var 1..n: q; % Variables for queens on the rows (or columns)

% ----------- Global constraints -----------

constraint alldifferent(q)::domain;
constraint alldifferent([q[i]+i | i in 1..n])::domain;
constraint alldifferent([q[i]-i | i in 1..n])::domain;

% ----------- Constraints decomposition -----------

predicate allDifferentRows(array[int] of var 1..n: q) =
    forall(i, j in 1..n where i < j) (
        q[i] != q[j]
    );
predicate allDifferentsecondConstraint(array[int] of var 1..n: q) =
    forall(i,j in 1..n where i<j) (
     q[i]+i!=q[j]+j
  );
predicate allDifferentthirdConstraint(array[int] of var 1..n: q) =
    forall(i,j in 1..n where i<j) (
     q[i]-i!=q[j]-j
  );
    
constraint allDifferentRows(q);
constraint allDifferentsecondConstraint(q);
constraint allDifferentthirdConstraint(q);

% Search for all solutions, using N = 28,29,30
solve :: int_search(q, input_order, indomain_min) satisfy;