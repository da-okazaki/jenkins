# Load the MNIST digit recognition dataset into R
# http://yann.lecun.com/exdb/mnist/
# assume you have all 4 files and gunzip'd them
# creates train$n, train$x, train$y  and test$n, test$x, test$y
# e.g. train$x is a 60000 x 784 matrix, each row is one digit (28x28)
# call:  show_digit(train$x[5,])   to see a digit.
# brendan o'connor - gist.github.com/39760 - anyall.org

show_digit <- function(arr784, col=gray(12:1/12), ...) {
  image(matrix(arr784, nrow=28)[,28:1], col=col, ...)
}

library(nnet)
load("train.Rdata")
load("test.Rdata")
load("mnist.nnet.model.rdata")

load("kadai.one.model.rdata")
load("kadai.one.train.rdata")

load("kadai.two.model.rdata")
load("kadai.two.train.rdata")

load("kadai.three.model.rdata")
load("kadai.three.train.rdata")

load("kadai.four.model.rdata")
load("kadai.four.train.rdata")

load("kadai.five.test.rdata")

load("kadai.six.test.rdata")
