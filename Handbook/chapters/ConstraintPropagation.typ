= Constraint Propagation & Global Constraints
== Local Consistency
A form of inference which detects inconsistent partial assignments. It's _local_, because we examine individual constraints.

Two popular local consistencies, domain based (they can change the domain values):
- Generalized Arc Consistency (GAC) or Domain Consistency
- Bounds Consistency (BC)

They detect inconsistent partial assignments of the form $X_i= j$, hence: $j$ can be removed from $D(X_i)$ via propagation and propagation can be implemented easily.

=== Arc Consistency
#set quote(block: true)
#quote(attribution: [Handbook of Constraint Programming])[
  _This is indeed a very simple and natural concept that guarantees every value in a domain to be consistent with every constraint._
]

=== Generalized Arc Consistency (GAC)
A constraint $C$ on $k$ variables $C(X_1,dots, X_k)$ gives the set of allowed combinations of values.
$ C subset.eq D(X_1) times dots  times D(X_k) $

Each allowed tuple $(d_1,dots,d_k) in C$ where $d_i in X_i$ is a support for $C$.

$C(X_1,dots, X_k)$ is GAC iff: $forall X_i in {X_1,dots , X_k}$, $forall v in D(X_i)$, $v$ belongs to a support for $C$. We call it just Arc Consistency (AC) when $k = 2$. 

A CSP is GAC iff all its constraints are GAC.

=== Bounds Consistency (BC) 
Defined for totally ordered domains. 

BC relaxes the domain of $X_i$ from $D(X_i)$ to 
$ [min(X_i) dots max(X_i)] $
A bound support is a tuple $(d_1, dots ,d_k) in C$ where $d_i in [min(X_i) dots max(X_i)]$. 

$C(X_1,dots, X_k)$ is BC iff: $forall X_i in {X_1,dots , X_k}$, $min(X_i)$ and $max(X_i)$ belong to a bound support. 

Disadvantages:
- BC might not detect all GAC inconsistencies in general. 
- We need to search more. 

Advantages:
- Might be easier to look for a support in a range than in a domain.
- Achieving BC is often cheaper than achieving GAC. 

Of interest in arithmetic constraints defined on integer variables with large domains. Achieving BC is enough to achieve GAC for monotonic constraints.

=== GAC = BC 
- All values of $D(X) <= max(Y)$ are GAC. 
- All values of $D(Y) >= min(X)$ are GAC. 
- Enough to adjust $max(X)$ and $min(Y)$. 
$ max(X) <= max(Y) and min(X) <= min(Y) $

== Constraint Propagation
A local consistency notion defines properties that a constraint $C$ must satisfy *after constraint propagation*. The only requirement is to achieve the required property on $C$.

=== Propagation Algorithms 
A propagation algorithm achieves a certain level of consistency on a constraint $C$ by removing the inconsistent values from the domains of the variables in $C$. The level of consistency depends on $C$.
- GAC if an efficient propagation algorithm can be developed
- Otherwise BC or a lower level of consistency

When solving a CSP with multiple constraints:
- propagation algorithms interact and wake up an already propagated constraint to be propagated again
- in the end, propagation reaches a fixed-point and all constraints reach a level of consistency;
The whole process is referred as *constraint propagation*.

=== Properties of Propagation Algorithms 
It may not be enough to remove inconsistent values from domains once. A propagation algorithm must wake up again when necessary, otherwise may not achieve the desired local consistency property. 
Multiple events can trigger a constraint propagation:
- when the domain of a variable changes (for GAC)
- when the domain bounds of a variable changes (for BC)
- when a variable is assigned a value.

=== Complexity of Propagation Algorithms 
Assume $|D(X_i)| = d$. 
Following the definition of the local consistency property: one time AC propagation on a $C(X_1,X_2)$ takes $O(d^2)$ time.

== Specialized Propagation
Propagation specific to a given constraint. 

Advantages:
- Exploits the constraint semantics
- Potentially much more efficient than a general propagation approach. 

Disadvantages:
- Limited use.
- Not always easy to develop one. 

Worth developing for recurring constraints.

== Global Constraints 
Capture complex, non-binary and recurring combinatorial substructures. 

Embed specialized propagation which exploits the substructure. 

*Modelling benefits*:
- Reduce the gap between the problem statement and the model.
- May allow the expression of constraints that are otherwise not possible to state using primitive constraints (semantic). 

*Solving benefits*:
- Strong inference in propagation (operational)
- Efficient propagation (algorithmic).

=== Counting Constraints 
Restrict the number of variables satisfying a condition or the number of times values are taken. 

*`Alldifferent Constraint`*

$"alldifferent"([X_1, X_2, dots, X_k])$ iff $X_i != X_j "for" i < j  in {1,dots ,k}$
- permutation constraint with $|D(X_i)| = k$

*`Nvalue Constraint`*

Constrains the number of *distinct values* assigned to the variables.\
$"nvalue"([X_1, X_2, dots, X_k], N)$ iff $N = |{X_i |1 <= i <= k }|$ 
- `alldifferent` when $N = k$

*`Global Cardinality Constraint`*

Constrains the number of times *each value is taken* by the variables.\ $"gcc"([X_1, X_2, dots, X_k], [v_1, dots, v_m], [O_1, dots, O_m])$ iff $forall j  in {1,dots , m} space O_j = |{X_i | X_i= v_j, 1 <= i <= k }|$
- `alldifferent` when $O_j <= 1$.

*`Among Constraint`*

Constrains the number of variables taken from a given set of values.\ $"among"([X_1, X_2, dots , X_k], s, N)$  iff $N = |{i |X_i in s, 1 <= i <= k }|$
- N can also be in interval $[l, dots, u]$

=== Sequencing Constraints
Ensure a sequence of variables obey certain patterns.

*`Sequence/AmongSeqConstraint`*

Constrains the number of values taken from a given set in any subsequence of $q$ variables.\
$"sequence"(l, u, q, [X_1, X_2, dots , X_k], s)$ iff $"among"([X_i, X_(i+1), dots , X_(i+q-1)], s, l, u)  forall i "s.t." 1 <= i <= k-q+1$

=== Scheduling Constraints
Help schedule tasks with respective release times, duration, and deadlines, using limited resources in a time interval.

*`Disjunctive Resource Constraint`* 

Requires that tasks do not overlap in time. Also known as `noOverlap` constraint.\ 
Given tasks $t_1, dots , t_k$ each associated with a start time $S_i$ and duration $D_i$: $"disjunctive"([S_1, dots , S_k],[D_1, dots , D_k]) "iff" forall i < j "s.t." (S_i + D_i <= S_j ) or (S_j + D_j <= S_i)$

*`Cumulative Resource Constraint`* 

Constrains the usage of a shared resource.\
Given tasks $t_1, dots ,t_k$ each associated with a start time $S_i$, duration $D_i$, resource requirement $R_i$, and a resource with a capacity $C$:\
$"cumulative"([S_1, dots , S_k], [D_1, dots , D_k], [R_1, dots,  R_k], C) $ iff $sum_(i | S_i <= u < S_i+D_i) R_i <= C space forall u in D$

=== Ordering Constraints
Enforce an ordering between the variables or the values.

*`Lexicographic Ordering Constraint` *

It requires a sequence of variables to be lexicographically less than or equal to another sequence of variables. 

$"lex" <= ([Y_1, Y_2, dots, Y_k], [Z_1, Z_2, dots, Z_k])$ holds iff: 

$ 
Y_1 <= Z_1 &and\
(Y_1= Z_1 arrow Y_2 <= Z_2)  &and\
(Y_1 = Z_1 and Y_2 = Z_2 arrow Y_3 <= Z_3) &and \ dots\
(Y_1= Z_1 and  Y_2= Z_2 dots. Y_k-1= Z_k-1 arrow Y_k<= Z_k)
$

*`Value Precedence Constraint`* 

Requires a value to precede another value in a sequence of variables.\
$"value_precede"(v_(j 1), v_(j 2), [X_1, X_2, dots , X_k])$ holds iff:\
$min{ i | X_i= v_(j 1) or i = k+1} < min{ i | X_i= v_(j 2) or i = k + 2}$.

== Specialized Propagation for Global Constraints 
We define two main approaches to develop specialized propagation for global constraints:
- constraint decomposition
- dedicated ad-hoc algorithm.

== Constraint Decomposition 
A global constraint is decomposed into smaller and simpler constraints, each of which has a known propagation algorithm. 

Propagating each of the constraints gives a propagation algorithm for the original global constraint. 
Effective and efficient method for some global constraints.

=== A decomposition of `among` 
Decomposition as a conjunction of logical constrains and a sum constraint. 
- $B_i "with" D(B_i) = {0, 1} "for" 1 <= i <= k$ 
- $C_i: B_i = 1 "iff" X_i in s "for" 1 <= i <= k$
- $C_(k+1): sum_i B_i = N$
$"AC"(C_i) space forall i $ and $"BC"(sum_i B_i = N)$ ensures GAC on among.

=== A decomposition of `lex`
$"lex" <= ([X_1, X_2, dots, X_k], [Y_1, Y_2, dots , Y_k])$

*Decomposition as a conjunction of disjunctions*

$B_i$ with $D(B_i) = {0, 1}$ for $1 <= i <= k+1$ to indicate the vectors have been ordered by position $i-1$. 
- $B_i= 0-C_i$:
$(B_i = B_(i+1) = 0 and X_i =Y_i ) &or\
(B_i = 0 and B_(i+1) = 1 and X_i < Y_i ) &or\ 
(B_i = B_(i+1) = 1) "for" 1 <= i <= k$

$"GAC"(C_i)$ for all $i$ ensures GAC on $"lex" <=$.

*Decomposition as a conjunction of implications*

AC on the decomposition is weaker than GAC on $"lex" <=$.
$"lex" <=$ is not GAC but the decomposition does not prune anything.

=== Constraint Decompositions 
May not always provide an effective propagation.

Often GAC on the original constraint is stronger than (G)AC on the constraints in the decomposition.

=== A Decomposition of `alldifferent`
Decomposition as a  conjunction of difference constraints. 

$C_(i j): X_i != X_j "for" i < j in {1, dots, k} "AC"(C_(i j)) forall i < j$ is weaker than GAC on `alldifferent`. 

Alldifferent is not GAC but the decomposition does not prune anything.

=== A Decomposition of `sequence`
Decomposition as a conjunction of among constraints.

$C_i: "among"([X_i, X_(i+1), dots, X_(i+q-1)], s, l, u) "for" 1 <= i <= k-q+1$

$"GAC"(C_i)$ for all i is weaker than GAC on sequence.

Sequence is not GAC but the decomposition does not prune anything.

=== Decomposition vs Ad-hoc Algorithm 
Even if a decomposition is effective, may not always provide an efficient propagation.\
Often propagating a constraint via an ad-hoc algorithm is faster than propagating the (many) constraints in the decomposition.

=== Incremental Computation 
A propagation algorithm is often called multiple times, so we don't want to re-compute everything each time.

Incremental computation can improve efficiency.
- At the first call, some partial results are cached.
- At the next invoke, we exploit the cached data.

=== Dedicated Propagation Algorithms 
Dedicated ad-hoc algorithms provide effective and efficient propagation. Often:
- GAC is maintained in polynomial time
- many more inconsistent values are detected compared to the decompositions
- computation is done incrementally. 
