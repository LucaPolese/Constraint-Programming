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
$ C subset.eq D(X_1) times … times D(X_k) $

Each allowed tuple $(d_1,dots,d_k) in C$ where $d_i in X_i$ is a support for $C$.

$C(X_1,dots, X_k)$ is GAC iff: $forall X_i in {X_1,…, X_k}$, $forall v in D(X_i)$, $v$ belongs to a support for $C$. We call it just Arc Consistency (AC) when $k = 2$. 

A CSP is GAC iff all its constraints are GAC.

=== Bounds Consistency (BC) 
Defined for totally ordered domains. 

BC relaxes the domain of $X_i$ from $D(X_i)$ to 
$ [min(X_i) dots max(X_i)] $
A bound support is a tuple $(d_1, dots ,d_k) in C$ where $d_i in [min(X_i) dots max(X_i)]$. 

$C(X_1,dots, X_k)$ is BC iff: $forall X_i in {X_1,…, X_k}$, $min(X_i)$ and $max(X_i)$ belong to a bound support. 

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

=== Global Constraints 
Capture complex, non-binary and recurring combinatorial substructures arising in a variety of applications. 

Embed specialized propagation which exploits the substructure. 

Modelling benefits:
- Reduce the gap between the problem statement and the model.
- May allow the expression of constraints that are otherwise not possible to state using primitive constraints (semantic). 

Solving benefits:
- Strong inference in propagation (operational)
- Efficient propagation (algorithmic).
