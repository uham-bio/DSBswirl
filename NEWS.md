# Version 0.4.0

All six German courses were checked against R 4.6.1 with the currently released
tidyverse packages (ggplot2 4.0.3, dplyr 1.2.1, tidyr 1.3.2) and updated. Every
one of the 62 lessons was played through in a real swirl session; none of the
1348 correct answers was rejected.

- Both assignment operators are now accepted: `x = 42` works wherever `x <- 42`
  does. Both pipes are accepted as well, so `%>%` no longer fails where `|>` is
  expected. (The courses still *teach* `<-` and `|>` - they just no longer
  insist on them.)
- DSB-01: fixed the help question in L05, which aborted under R >= 4.3 with
  `'length = 3' in coercion to 'logical(1)'`.
- DSB-03: added `tidyr` to L06, where the model solution uses `drop_na()`;
  fixed a missing pipe in the L07 exercise script.
- DSB-04: added `dplyr` to L03b, where an answer test uses `mutate()`; replaced
  the deprecated dot-dot notation `..count..` with `after_stat(count)` and
  `element_rect(size =)` with `linewidth =`.
- DSB-05: added `dplyr` to L05; repaired the L07 exercise script
  (`columnnames.R`).
- All course packages are now installed together with DSBswirl: `gridExtra`,
  `ggmap`, `maps`, `mapproj`, `plotly` and `htmlwidgets` used to be missing, so
  swirl had to ask learners to install them in the middle of a lesson.


# Version 0.3.0

- Replaced the deprecated ggplot 2 functions `coord_trans()` and `borders()` with 
the new functions `coord_transform()` (since 4.0.0 release) and `annotation_borders()` 
(since 3.4.0).
