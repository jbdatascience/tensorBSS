tSIR <-
  function(x, y, h = 10, ...){
    
    if(is.null(norm)) norm <- rep(FALSE, length(dim(x)) - 1)
    
    if(length(dim(x)) == 2){
      stop("Observations must be tensor of at least order 2 (matrices).")
      # returnlist <- FOBI(t(x))
      # returnlist$S <- t(returnlist$S)
      # returnlist2 <- list(S = returnlist$S, W = returnlist$W, Xmu = returnlist$Xmu, datatype = "iid")
      # class(returnlist2) <- c("tbss", "bss") 
      # return(returnlist2)
    }
    
    xmu <- apply(x, 1:(length(dim(x)) - 1), mean)
    
    stand <- tensorStandardize(x)
    x <- stand$x
    rotat <- tSIRRotate(x, y, h, ...)
    x <- rotat$x
    
    W <- list()
    for(i in 1:length(stand$S)){
      W[[i]] <- rotat$U[[i]]%*%stand$S[[i]]
    }
    
    returnlist <- list(S = x, W = W, Xmu = xmu, datatype = "iid")
    
    class(returnlist) <- c("tbss", "bss") 
    
    return(returnlist)
  }