#' Install (German) DSB swirl courses
#'
#' Install all or a selection of swirl courses developed for the DSB (Data Science in
#' Biology) program within the biology department of the University of Hamburg (UHH).
#' The package currently includes seven swirl courses that can be installed
#' using this \code{install_dsb_courses} function.
#'
#' @param courses character; single string or vector with the name of the courses to be
#' installed. The default setting is 'all', which installs all German courses, but you
#' can also select from the following courses:
#' 'DSB-01', 'DSB-02', 'DSB-03', 'DSB-04', 'DSB-05', 'DSB-06', 'Data analysis with R'.
#' See \emph{Details} for the topics each course covers.
#' @param force logical; should course installation be forced if the course is already
#'   installed? The default value is \code{FALSE}.
#'
#' @details
#' The following swirl courses can be installed (currently only in German):
#' \describe{
#'   \item{DSB-01}{R Grundlagen (Basics in R)}
#'   \item{DSB-02}{Datenexploration mit R (Data exploration in R))}
#'   \item{DSB-03}{Datenaufbereitung oder per Anleitung durchs Tidyversum
#'                 (Data wrangling and introduction to tidyverse)}
#'   \item{DSB-04}{Datenvisualisierung mit ggplot2 (Data visualization with ggplot2)}
#'   \item{DSB-05}{Handling spezieller Datentypen (Working with special data types)}
#'   \item{DSB-06}{Fortgeschrittene R Programmierung (Advanced R programming)}
#' }
#' The following swirl course is in English:
#' \describe{
#'   \item{Data analysis with R}{From R basics to visualization and statistical modelling}
#'  }
#'
#' @examples
#' \dontrun{
#'  # Install all German courses (default)
#'  install_dsb_courses()
#'
#'  # Install only the DSB-01 (R basics) course
#'  install_dsb_courses(courses = "DSB-01")
#'
#'  # Install the courses DSB-01, DSB-04, and DSB-05
#'  install_dsb_courses(courses = c("DSB-01", "DSB-04", "DSB-05"))
#' }
#' @export
#'
install_dsb_courses <- function(courses = "all", force = FALSE) {

  current_courses <- c("DSB-01", "DSB-02", "DSB-03", "DSB-04", "DSB-05", "DSB-06", "Data analysis with R")
  # Validate course selection
  if (!all(courses %in% c("all", current_courses))) {
    stop(paste0("Choose 'all' German courses or provide a single character or vector ",
      "with one of the following courses: ",
      "'DSB-01', 'DSB-02', 'DSB-03', 'DSB-04', 'DSB-05', 'DSB-06', 'Data analysis with R'. ",
      "For more info see the functions' documentation.")
    )
  }
  if (length(courses) == 1) {
    if (courses == "all") {
      courses <- current_courses[1:6]
    }
  }
  courses_swc <- c(
    "DSB-01-R_Grundlagen.swc",
    "DSB-02-Datenexploration_mit_R.swc",
    "DSB-03-Datenaufbereitung_oder_per_Anleitung_durchs_Tidyversum.swc",
    "DSB-04-Datenvisualisierung_mit_ggplot2.swc",
    "DSB-05-Handling_spezieller_Datentypen.swc",
    "DSB-06-Fortgeschrittene_R_Programmierung.swc",
    "Data_analysis_with_R.swc"
  )
  n <- length(courses)

  ### Check if swirl is installed
  swirl_path <- system.file(package = "swirl")
  if (nchar(swirl_path) == 0) {
    utils::install.packages("swirl")
    swirl_path <- system.file(package = "swirl")
  }

  ### Function for copying and installation
  copy_and_install <- function(course, force) {
    get_swirl_course_path <- function(){
      tryCatch(swirl_courses_dir(),
        error = function(c) {file.path(find.package("swirl"),"Courses")}
      )
    }
    path_dsb <- file.path(find.package("DSBswirl"),"Courses", course)
    path_swirl <- file.path(get_swirl_course_path(), course)
    file.copy(from = path_dsb, to = path_swirl, overwrite = TRUE)
    swirl::install_course(swc_path = path_swirl, force = force)
    unlink(path_swirl, force = TRUE)
  }

  ### Copy course files into swirl folder and install
  for (i in 1:n) {
    if (courses[i] == "Data analysis with R") {
      sel_course <- "Data_analysis_with_R.swc"
    } else {
      sel_course <- grep(courses[i], courses_swc, value = TRUE)
    }
    copy_and_install(course = sel_course, force = force)
  }

}


### Copied from swirl (for the get_swirl_course_path() function):
swirl_courses_dir <- function() {
  scd <- getOption("swirl_courses_dir")
  if (is.null(scd)) {
    file.path(find.package("swirl"), "Courses")
  }
  else {
    scd
  }
}
