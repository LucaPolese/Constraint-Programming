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

#include "chapters/Introduction.typ"
#include "chapters/Modeling.typ"