int: n;
array[0..n-1] of var 0..n-1: x;
 
% meta constraint
constraint forall(i in 0..n-1)(x[i] = sum(j in 0..n-1)(x[j] = i));

% the first implied constraint
constraint sum(i in 0..n-1)(x[i])=n;

% the second implied constraint
constraint sum(i in 0..n-1)(x[i]*i)=n;

solve satisfy;

output [ "x = \(x);\n" ] ;