replace_value <- function(x){
        sh <- combined_activity$activity %in% as.character(x)
        tmp <- as.character(activities[x,1])
        combined_activity$activity[sh] <<- tmp
}