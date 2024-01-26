int: n;  
int: w;  
int: h;  

array[1..n] of int: ws;
array[1..n] of int: hs;

% Variables
array[1..n] of var 0..w: x;
array[1..n] of var 0..h: y; 

% Constraints
constraint forall(p in 1..n)(x[p] + ws[p] <= w /\ y[p] + hs[p] <= h);

% No overlap constraints
constraint forall(p1, p2 in 1..n where p1 < p2)( (x[p1] + ws[p1] <= x[p2]) \/ (x[p2] + ws[p2] <= x[p1]) \/ (y[p1] + hs[p1] <= y[p2]) \/ (y[p2] + hs[p2] <= y[p1]) );

solve satisfy;