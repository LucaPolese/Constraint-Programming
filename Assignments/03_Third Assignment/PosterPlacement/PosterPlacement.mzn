include "globals.mzn";

% Parameters
int: n;  
int: w;  
int: h; 

array[1..n] of var int: ws;
array[1..n] of var int: hs;
array[1..n] of var 0..w: X; 
array[1..n] of var 0..h: Y; 

array[1..n*2] of var 0..max(w-1, h-1): allvars;


% Each shape must be inside the sallvarsuare
constraint forall(i in 1..n)(X[i] >= 0 /\ X[i] + ws[i] <= w /\ Y[i] >= 0 /\ Y[i] + hs[i] <= h);

%ordered perimeter
constraint forall (i in 1..n)(allvars[2*i]=Y[i] /\ allvars[2*i-1]=X[i]);

% No overlap with diffn global constraint
constraint diffn(X, Y, ws, hs);

%input order - min value 
%solve:: int_search(allvars, input_order, indomain_min) satisfy;

%input order - random value
%solve:: int_search(allvars, input_order, indomain_random) satisfy;
 
%min domain size - min value
%solve:: int_search (allvars,first_fail, indomain_min) satisfy;

%min domain size - random value
%solve:: int_search (allvars,first_fail, indomain_random) satisfy;

%domWdeg - minvalue
%solve:: int_search (allvars, dom_w_deg,indomain_min) satisfy;

%domWdeg - random value
%solve:: int_search (allvars, dom_w_deg,indomain_random) satisfy;