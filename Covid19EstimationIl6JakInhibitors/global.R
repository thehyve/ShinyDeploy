source("DataPulls.R")
source("PlotsAndTables.R")

shinySettings <- list(dataFolder = "./data", blind = TRUE)
dataFolder <- shinySettings$dataFolder
blind <- shinySettings$blind
connection <- NULL
positiveControlOutcome <- NULL

splittableTables <- c("covariate_balance", "preference_score_dist", "kaplan_meier_dist")

files <- list.files(dataFolder, pattern = ".rds")

# Find part to remove from all file names (usually databaseId):
databaseFileName <- files[grepl("^database", files)]
removeParts <- paste0(gsub("database", "", databaseFileName), "$")

# Remove data already in global environment:
for (removePart in removeParts) {
  tableNames <- gsub("_t[0-9]+_c[0-9]+$", "", gsub(removePart, "", files[grepl(removePart, files)])) 
  camelCaseNames <- SqlRender::snakeCaseToCamelCase(tableNames)
  camelCaseNames <- unique(camelCaseNames)
  camelCaseNames <- camelCaseNames[!(camelCaseNames %in% SqlRender::snakeCaseToCamelCase(splittableTables))]
  suppressWarnings(
    rm(list = camelCaseNames)
  )
}

# Load data from data folder. R data objects will get names derived from the filename:
loadFile <- function(file, removePart) {
  tableName <- gsub("_t[0-9]+_c[0-9]+$", "", gsub(removePart, "", file)) 
  camelCaseName <- SqlRender::snakeCaseToCamelCase(tableName)
  if (!(tableName %in% splittableTables)) {
    newData <- readRDS(file.path(dataFolder, file))
    colnames(newData) <- SqlRender::snakeCaseToCamelCase(colnames(newData))
    if (exists(camelCaseName, envir = .GlobalEnv)) {
      existingData <- get(camelCaseName, envir = .GlobalEnv)
      newData <- rbind(existingData, newData)
      newData <- unique(newData)
    }
    assign(camelCaseName, newData, envir = .GlobalEnv)
  }
  invisible(NULL)
}
for (removePart in removeParts) {
  lapply(files[grepl(removePart, files)], loadFile, removePart)
}

tcos <- unique(cohortMethodResult[, c("targetId", "comparatorId", "outcomeId")])
tcos <- tcos[tcos$outcomeId %in% outcomeOfInterest$outcomeId, ]

outcomeOfInterest$definition <- NULL
outcomeOfInterest <- outcomeOfInterest[!duplicated(outcomeOfInterest), ]
outcomeOfInterest <- outcomeOfInterest[!(outcomeOfInterest$outcomeId %in% c(4, 26, 27)), ]

exposureOfInterest$definition <- NULL
exposureOfInterest <- exposureOfInterest[!duplicated(exposureOfInterest), ]

cohortMethodAnalysis$definition <- NULL
cohortMethodAnalysis <- cohortMethodAnalysis[!duplicated(cohortMethodAnalysis), ]

unblind <-
  (cohortMethodResult$targetId == 31 & cohortMethodResult$comparatorId == 32 & cohortMethodResult$databaseId == "Open Claims") | # sari vs barci
  (cohortMethodResult$targetId == 29 & cohortMethodResult$comparatorId == 30 & cohortMethodResult$databaseId == "Open Claims")   # toci vs adalim

cohortMethodResult$rr[!unblind] <- NA
cohortMethodResult$ci95Ub[!unblind] <- NA
cohortMethodResult$ci95Lb[!unblind] <- NA
cohortMethodResult$logRr[!unblind] <- NA
cohortMethodResult$seLogRr[!unblind] <- NA
cohortMethodResult$p[!unblind] <- NA
cohortMethodResult$calibratedRr[!unblind] <- NA
cohortMethodResult$calibratedCi95Ub[!unblind] <- NA
cohortMethodResult$calibratedCi95Lb[!unblind] <- NA
cohortMethodResult$calibratedLogRr[!unblind] <- NA
cohortMethodResult$calibratedSeLogRr[!unblind] <- NA
cohortMethodResult$calibratedP[!unblind] <- NA



