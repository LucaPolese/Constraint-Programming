include "alldifferent.mzn";
include "inverse.mzn";
include "lex_lesseq.mzn";

int: n;
array [1..n] of var 1..n: X; 
array [1..n, 1..n] of var bool: B;

% Constraints
constraint alldifferent(X)::domain;
constraint alldifferent([X[i]+i | i in 1..n])::domain;
constraint alldifferent([X[i]-i | i in 1..n])::domain;

% Lexicographic symmetry breaking constraints
constraint
    lex_lesseq(array1d(B), [ B[j,i] | i,j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i in 1..n, j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i in reverse(1..n), j in 1..n ])
/\  lex_lesseq(array1d(B), [ B[i,j] | i,j in reverse(1..n) ])
/\  lex_lesseq(array1d(B), [ B[j,i] | i,j in reverse(1..n) ])
;

% Channeling Constraints
constraint forall (i,j in 1..n) ( B[i,j] <-> (X[i]=j) );

% Search for all solutions, using N = 8, 9, 10, and 12.
solve satisfy;