"panel.ellipse1" <- 
  function(x=0,y=0,xs=1,ys=1,r=0,col.smooth,add=TRUE,segments=51,...) {
    #based upon John Fox's ellipse functions
    angles <- (0:segments) * 2 * pi/segments
    unit.circle <- cbind(cos(angles), sin(angles))
    # shape <- diag(c(1+r,1-r)) %*% matrix(c(r,sqrt(1-r^2),-sqrt(1-r^2),r),ncol=2,byrow=TRUE)
    if(!is.na(r)) {
      if (abs(r)>0 )theta <- sign(r)/sqrt(2) else theta=1/sqrt(2) 
      
      shape <- diag(c(sqrt(1+r),sqrt(1-r))) %*% matrix(c(theta,theta,-theta,theta),ncol=2,byrow=TRUE)
      ellipse <- unit.circle %*% shape 
      ellipse[,1] <- ellipse[,1]*xs + x
      ellipse[,2] <- ellipse[,2]*ys + y
      points(x,y,pch=19,col=col.smooth,cex=1.5 )  #draw the mean
      lines(ellipse, ...)   }    
  }




panel.cor <- function(x, y, digits=2,cex.cor,meth="Spearman")
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- (cor(x, y, method="spearman"))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  test <- cor.test(x,y, method="spearman")
  Signif <- ifelse(round(test$p.value,3)<0.001,"p<0.001",paste("p=",round(test$p.value,3)))  
  text(0.5, 0.75, paste("r=",txt),col="#0072B2", cex=abs(r)*2.75 )
  text(.5, .25, Signif, cex=1.25)
}

panel.smooth<-function (x, y,pch = par("pch"),bg=bg, 
                        col.smooth = "black", span = 2/3, iter = 3, ...) 
{
  
  xm <- mean(x,na.rm=TRUE)
  ym <- mean(y,na.rm=TRUE)
  xs <- sd(x,na.rm=TRUE)
  ys <- sd(y,na.rm=TRUE)
  r = cor(x, y,use="pairwise")
  
  points(x, y, pch = 19, col="#009E73", ...)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) 
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
          col = col.smooth, ...)
  
  panel.ellipse1(xm,ym,xs,ys,r,col=col.smooth,...)
  
}

panel.hist <- function(x,...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y, col= "#F0E442", ...)
  tryd <- try( d <- density(x,na.rm=TRUE,bw="nrd",adjust=1.2),silent=TRUE)
  if(class(tryd) != "try-error") {
    d$y <- d$y/max(d$y)
    lines(d)}
}

pairs(stroke_data[,c()],
      lower.panel=panel.smooth, upper.panel=panel.cor,diag.panel=panel.hist,
      labels=c(), 
      font.labels=.5,
      cex.labels=1)