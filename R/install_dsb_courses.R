#' Install (German) DSB swirl courses
#'
#' Install all or a selection of swirl courses developed for the DSB (Data Science in
#' Biology) program within the biology department of the University of Hamburg (UHH).
#' The package comes currently with five swirl courses that can be installed
#' using this \code{install_dsb_courses} function.
#'
#' @param courses character; single string or vector with the name of the courses to be
#' installed. By default, all courses will be installed but you can also select from the
#' the following courses: 'DSB-01', 'DSB-02', 'DSB-03', 'DSB-04', 'DSB-05'. See under
#' details what topics each course covers.
#' @param force logical; should course installation be forced if the course is already
#'   installed? The default value is FALSE.
#'
#' @details
#' The following swirl courses can be installed (currently only in German):
#' \describe{
#'   \item{DSB-01}{Basics in R (R Grundlagen)}
#'   \item{DSB-02}{Data exploration with R (Datenexploration mit R)}
#'   \item{DSB-03}{Data warangling and introduction to tidyverse (Datenaufbereitung
#'     oder per Anleitung durchs Tidyversum)}
#'   \item{DSB-04}{Data visualization with ggplot2 (Datenvisualisierung mit ggplot2)}
#'   \item{DSB-05}{Handling of special data types (Handling spezieller Datentypen)}
#'  }
#'
#' @examples
#' \dontrun{
#'  # Install all courses (default)
#'  install_dsb_courses()
#'  # Install only course DSB-01 (R basics)
#'  install_dsb_courses(courses = "DSB-01")
#'  # Install the course DSB-01, DSB-04, and DSB-05
#'  install_dsb_courses(courses = c("DSB-01", "DSB-04", "DSB-05"))
#' }
#' @export
#'
install_dsb_courses <- function(courses = "all", force = FALSE) {

  current_courses <- c("DSB-01", "DSB-02", "DSB-03", "DSB-04", "DSB-05")
  # Validate course selection
  if (!all(courses %in% c("all", current_courses))) {
    stop(paste0("Choose 'all' courses or provide a single character or vector ",
      "with one of the following courses: ",
      "'DSB-01', 'DSB-02', 'DSB-03', 'DSB-04', 'DSB-05'. ",
      "For more info see the functions' documentation.")
    )
  }
  if (length(courses) == 1) {
    if (courses == "all") {
      courses <- current_courses
    }
  }
  courses_swc <- c(
    "DSB-01-R_Grundlagen.swc",
    "DSB-02-Datenexploration_mit_R.swc",
    "DSB-03-Datenaufbereitung_oder_per_Anleitung_durchs_Tidyversum.swc",
    "DSB-04-Datenvisualisierung_mit_ggplot2.swc",
    "DSB-05-Handling_spezieller_Datentypen.swc"
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
    sel_course <- grep(courses[i], courses_swc, value = TRUE)
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
