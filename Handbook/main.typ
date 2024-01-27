#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: smallcaps("Handbook of Decision Making with Constraint Programming"),
  authors: (
    (
      name: "Luca Polese", 
      email: "luca.polese@studio.unibo.it", 
      affiliation: smallcaps("Alma Mater Studiorum - Università di Bologna")),
  ),
  date: datetime.today().display("[month repr:long] [day], [year]"),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!
= Introduction 
A combinatorial decision-making problem is a problem that is computationally difficult to solve (NP-Hard) that can only be solved by intelligent search. It's experimental, a time saver and it can reduce the cost of the environmental impact. 
The main purpose of CDM is that we want to make a decision within many combinations of possibilities. Each one is subject to restriction (that we will call constraints).  
- we choose any solution that meet all constraints $arrow$ constraint satisfaction 
- we choose the best solution according to an objective $arrow$ combinatorial optimization

== Constraint Programming
It's a *declarative programming paradigm* for stating and solving combinatorial optimization problems.

User *models* a decision problem by formalizing: 
- _unknowns_ of the decision (decision variables : $X_i$); 
- possible _values_ for unknowns (domains : $D(X_i)=  {v_j}$);
- _relations_ between the unknowns (constraints : $r(X_i, X_i’)$).

=== Pros of Constraint Programming
- It provides a rich language for expressing constraint and defining search procedures
- Easy to model
- Easy control of the search
- Main focus on constraints and feasibility
- Constraints reductions in the search space: 
  - More constraints =  more domain reductions $arrow$ easier to solve.

=== Cons of Constraint Programming
- There is no focus on objective function
- There is no focus on optimality

=== Tradeoff between CP and ILP
The best choice to focus on optimality is to adopt hybrid models.

=== Solver
A *constraint solver* finds a _solution_ to the _model_ (or proves that no solution exists)  by assigning a value to every variable ($X_i arrow.l v_j$) via a search algorithm.

The constraint solver enumerates all value combinations (variable-value) via backtracking tree search and examines constraints.

== Constraint Solver 
- _Enumerates_ all possible variable-value combinations via a systematic backtracking tree search. 
- _Guesses_ a value for each variable. 
- During search, _examines_ the constraints to _remove incompatible values_ from the domains of the future (unexplored) variables, via *propagation*
- _Shrinks_ the domains of the *future variables*