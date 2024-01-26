include "globals.mzn";

% Parameters
int: n;  
int: w;  
int: h;  


array[1..n] of var int: ws;
array[1..n] of var int: hs;
array[1..n] of var 0..w: shapeX; 
array[1..n] of var 0..h: shapeY; 

% Each shape must be inside the square
constraint forall(i in 1..n)(shapeX[i] >= 0 /\ shapeX[i] + ws[i] <= w /\ shapeY[i] >= 0 /\ shapeY[i] + hs[i] <= h);




% No overlap with diffn global constraint
constraint diffn(shapeX, shapeY, ws, hs);

solve satisfy;