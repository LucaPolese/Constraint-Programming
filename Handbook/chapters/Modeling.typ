= Modeling
== Formalization as a Constraint Satisfaction Problem 
A CSP $P$ is a triple $P = \<X, D, C\>$ where 
- $X$ is a set of decision variables ${X_1, dots, X_n}$, 
- $D$ is a set of domains ${D_1, dots, D_n}$ for $X$ so that $D_i$ is a set for $X_i$\ (non binary, with finite domain), 
- $C$ is a set of constraints ${C_1,dots, C_n}$ so that $C_i$ is a relation over $X_j, dots ,X_k$ \ denoted as $C(X_j, dots, X_k)$. 

A solution to a CSP $P$ is an $n$-tuple $A = \<a_1, a_2, space dots space, a_n\>$ where every $a_i$ is an assignment of value to the variable $X_i$ which satisfies all constraints simultaneously.\
If the set of solutions is empty, the CSP is _unsatisfactory_.

== Constraint Optimization Problems
CSP enhanced with an optimization criterion\
Formally, $<X,D,C,f>$ where $f$ is the formalization of the optimization criterion as an objective variable.\
Our goal is to minimize/maximize $f$.

== Constraints
We can use two different approaches to determine the constraints:
- Any constraint can be expressed by listing all allowed combinations.
  - General but inconvenient and inefficient with large domains. 
- Usually it's better to use relations between objects. 
  - Less general, but more compact and clear.

=== Properties of constraints
- The order of imposition does not matter
- Non-directional: a constraint between $X$ and $Y$ can be used on $Y$ and X and vice versa
- Rarely independent, usually variables are shared between different constraints.

=== Types of constraint
#table(
  columns: (1fr, 2fr),
  inset: 5pt,
  align: horizon,
  [*Type*],[*Example*],
  [Algebraic expressions], [$x_1 > x_2$],
  [Extensional constraints \ (_table_ constraints)], [$(X, Y, Z) in {(a, a, a), (b, b, b)}$],
  [Variables as subscripts \ (_element_ constraints)], [$Y = "cost"[X]$ \ (where cost is an array of parameters)],
  [Logical relations], [$(X<Y) or (Y<Z) arrow C$],
  [Global constraints], [$"alldifferent"([X_1, X_2, X_3])$],
  [Meta-constraints], [$sum_i (X_i > t_i) <= 5$ \ (at most 5 variables should satisfy this constraint)],
)

== Modeling is critical
- Choice of variables and domains defines the search space size:\ $|D(X_1)| times |D(X_2)| times dots times |D(X_n)| arrow $ exponential! 
- Choice of constraints defines:
  - how search space can be reduced 
  - how search can be guided.

== Symmetry in CSPs 
#set quote(block: true)
#quote(attribution: [Handbook of Constraint Programming])[
  _Search can revisit equivalent states over and over again._
]

By *symmetry* we mean that:

#quote(attribution: [Handbook of Constraint Programming])[
  _Given a solution, which by definition satisfies all the constraints, we can find a *new solution* by applying any *symmetry* to the first solution we find. [dots] Why is symmetry important? The main reason is that we can *exploit symmetry* to *reduce* the amount of *search* needed to solve the problem._
]

A CSP can create many symmetrically equivalent search states each of which leads to a solution/failure and that will have many symmetrically equivalent states.

This is bad when we're proving optimality, infeasibility or looking for all solutions. 

=== Permutation
Defined over a discrete set $S$ as a 1-1 function $pi$: $S arrow S$, intuitively we re-arrange a set of elements.

=== Variable Symmetry
It's a permutation $pi$ of the variable indices s.t. for each (un)feasible (partial) assignment, we can re-arrange the variables according to $pi$ and obtain another (un)feasible (partial) assignment. 
- Intuitively: permuting variable assignments.
- $pi$ identifies a specific symmetry.  

=== Value Symmetry 
It's a permutation $pi$ of the values s.t.for each (un)feasible (partial) assignment, we can re-arrange the values according to $pi$ and obtain another (un)feasible (partial) assignment.
- Intuitively: permuting values. 
- $pi$ identifies a specific symmetry.  

=== Symmetry Breaking Constraints 
If we break the previous symmetries, then we reduce the set of solutions and search space.
- Not logically implied by the constraints of the problem.
- Attention: at least one solution from each set of symmetrically equivalent solutions must remain.

=== Dual Viewpoint 
- Viewing a problem $P$ from different perspectives may result in different models for $P$. Each model yields the same set of solutions. Each model exhibits in general a different representation of $P$. Can be hard to decide which is better.

=== Combined model
When we have multiple models that have relevant pros and cons we can opt for combining them. This way we can keep all the models and use channeling constraints to maintain consistency between the variables of the two models.

Benefits: 
- Easier to express constraints
- Enhanced constraint propagation 
- More options for search variables.