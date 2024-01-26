include "alldifferent.mzn";

par int: N;
array[1..N, 1..N] of int: start;
array[1..N, 1..N] of var 1..N: square;

% If the value is different from 0, it means that it already has a color, so 
% the final square will have the same values of start's square.
constraint forall (i in 1..N, j in 1..N where start[i, j] > 0) (
  square[i, j] = start[i, j]
);

constraint forall (i in 1..N) (
  alldifferent([square[i, j] | j in 1..N])::domain
);
                        
constraint forall (j in 1..N) (
  alldifferent([square[i, j] | i in 1..N])::domain
);

% ------- Default search -------
%solve satisfy;

% ------- domWdeg - random value -------
%solve:: int_search(square, dom_w_deg, indomain_random) satisfy;

% ------- domWdeg - random value + restarting (employing the Luby strategy with L = 250 -------
solve :: int_search(square, dom_w_deg, indomain_random) :: restart_luby(250) satisfy;