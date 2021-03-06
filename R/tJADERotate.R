tJADERotate <-
function(x, k = NULL, maxiter, eps){
  r <- length(dim(x)) - 1
  
  rotateStack <- list()
  for(m in 1:r){
    pm <- dim(x)[m]
    if(is.null(k)){
      this_k <- pm
    }
    else{
      this_k <- k[m]
    }
    ijStack <- NULL
    for(i in 1:pm){
      for(j in 1:pm){
        if(abs(i - j) < this_k){
          ijStack <- rbind(ijStack, mModeTJADEMatrix(x, m, i, j))
        }
        # ijStack[((i-1)*pm^2 + (j-1)*pm + 1):((i-1)*pm^2 + j*pm) , 1:pm] <- mModeTJADEMatrix(x, m, i, j)
      }
    }
    rotateStack[[m]] <- t(frjd(ijStack, maxiter=maxiter, eps=eps)$V)
  }
  
  
  for(m in 1:r){
    x <- tensorTransform(x, rotateStack[[m]], m)
  }
  
  return(list(x = x, U = rotateStack))
}
