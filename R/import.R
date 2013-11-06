.import_as_factors <- 
    function(data, features, split=",")
{
    ## create factor levels. can't parse stateOrder directly because 
    ## state can contain ','
    idx <- features$Key %in% "state"
    state <- split(features$Value[idx], features$Feature[idx])
    idx <- features$Key %in% "stateOrder"
    stateOrder <- setNames(features[idx, "Value"], features$Feature[idx])
    ## need both state and stateOrder
    keep <- intersect(intersect(names(state), names(stateOrder)), names(data))
    state <- state[match(keep, names(state))]
    stateOrder <- stateOrder[match(keep, names(stateOrder))]
    ## order states by stateOrder; trying to be robust to ambiguous
    ## possibilities of stateOrder
    lvls <- Map(function(state, stateOrder) {
        o <- order(nchar(state), decreasing=TRUE)
        final <- sapply(state[o], function(s) {
            idx <- regexpr(s, stateOrder, fixed=TRUE)
            len <- attr(idx, "match.length")
            substr(stateOrder, idx, idx + len) <- 
                paste(rep("X", len), collapse="")
            idx
        })
        names(sort(final))
    }, state, stateOrder)

    ## coerce to factor
    data[,names(lvls)] <- Map(factor, data[,names(lvls)], levels=lvls)
    data
}

.import_as_AnnotatedDataFrame <-
    function(clinical, features,
       featureKeys=c("shortTitle", "longTitle", "valueType"))
{
    ## FIXME: DataFrame
    fid <- unique(features$Feature)
    m <- matrix(character(), length(fid), length(featureKeys),
        dimnames=list(fid, featureKeys))
    features1 <- as.matrix(features[features$Key %in% featureKeys,])
    m[features1[,c("Feature", "Key")]] <- features1[,"Value"]
    metadata <- as.data.frame(m)[colnames(clinical), , drop=FALSE]
    AnnotatedDataFrame(clinical, metadata)
}
