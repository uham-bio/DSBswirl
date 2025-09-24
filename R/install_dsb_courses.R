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

  # Ensure swirl is available (no auto-install in non-interactive scripts)
  if (!requireNamespace("swirl", quietly = TRUE)) {
    stop("Package 'swirl' is not installed. Please install.packages('swirl') first.")
  }

  # Available course names
  available <- c("DSB-01", "DSB-02", "DSB-03", "DSB-04", "DSB-05", "DSB-06", "Data analysis with R")

  # Map display names -> zip filenames that are shipped in inst/Courses
  zip_map <- c(
    "DSB-01" = "DSB-01-R_Grundlagen.zip",
    "DSB-02" = "DSB-02-Datenexploration_mit_R.zip",
    "DSB-03" = "DSB-03-Datenaufbereitung_oder_per_Anleitung_durchs_Tidyversum.zip",
    "DSB-04" = "DSB-04-Datenvisualisierung_mit_ggplot2.zip",
    "DSB-05" = "DSB-05-Handling_spezieller_Datentypen.zip",
    "DSB-06" = "DSB-06-Fortgeschrittene_R_Programmierung.zip",
    "Data analysis with R" = "Data_analysis_with_R.zip"
  )

  # "all" = all German courses
  if (identical(courses, "all")) courses <- available[1:6]

  # Validate course selection
  if (!all(courses %in% available)) {
    stop(paste0("Choose 'all' to get all German courses or provide a single character or vector ",
      "with one of the following courses: ",
      "'DSB-01', 'DSB-02', 'DSB-03', 'DSB-04', 'DSB-05', 'DSB-06', 'Data analysis with R'. ",
      "For more info see the functions' documentation.")
    )
  }

  # Get source and target paths
  zip_root <- system.file("courses", package = "DSBswirl", mustWork = TRUE)
  # copied from swirl (for the get_swirl_course_path() function):
  get_swirl_courses_dir <- function() {
    scd <- getOption("swirl_courses_dir")
    if (is.null(scd)) {
      file.path(find.package("swirl"), "Courses")
    }
    else {
      scd
    }
  }
  swirl_courses_dir <- get_swirl_courses_dir()
  # if (!dir.exists(swirl_courses_dir)) dir.create(swirl_courses_dir,
  #   recursive = TRUE, showWarnings = FALSE)

  ### Unzip, copy and install each course
  for (nm in courses) {
    zip_file <- zip_map[[nm]]
    zip_path <- file.path(zip_root, zip_file)
    if (!file.exists(zip_path)) stop("Course archive not found: ", zip_path)

    # Unzip to tempdir
    tmp <- file.path(tempdir(), paste0("dsb_course_", nm, "_",
      as.integer(runif(1, 1e6, 9e6))))
    dir.create(tmp, recursive = TRUE, showWarnings = FALSE)
    utils::unzip(zipfile = zip_path, exdir = tmp)

    # Extract .swc file
    contents <- list.files(tmp, all.files = TRUE, recursive = TRUE, include.dirs = TRUE)
    swc_file <- grep("\\.swc$", contents, value = TRUE)

    # Copy and install file
    if (length(swc_file) > 0) {
      swc_full <- file.path(tmp, swc_file[[1]])
      target_swc <- file.path(swirl_courses_dir, basename(swc_full))
      file.copy(from = swc_full, to = target_swc, overwrite = TRUE)
      swirl::install_course(swc_path = target_swc, force = force)
      # aufräumen: die abgelegte .swc kann weg
      unlink(target_swc, force = TRUE)
    } else {
      stop("Archive format not recognized for '", nm,
        "'. Expecting either a .swc file.")
    }
    unlink(tmp, recursive = TRUE, force = TRUE)

  }

  invisible(courses)

}


