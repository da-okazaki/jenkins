#sample.r
#評価のためのテスト用データの10番目の手書き画像の中身を見る
test$x[10,]
#評価のためのテスト用データの10番目の手書き画像を見る
show_digit(test$x[10,])
#評価のためのテスト用データの10番目の手書き画像の答えを見る
test$y[10]
#評価のためのテスト用データの13番目の手書き画像を見る
show_digit(test$x[13,])
#評価のためのテスト用データの13番目の手書き画像の答えを見る
test$y[13]
#評価のためのテスト用データの17番目の手書き画像を見る
show_digit(test$x[17,])
#評価のためのテスト用データの17番目の手書き画像の答えを見る
test$y[17]
#評価のためのテスト用データの21番目の手書き画像を見る
show_digit(test$x[21,])
#評価のためのテスト用データの21番目の手書き画像の答えを見る
test$y[21]
test_index<-c(10,13,17,21)
test_dataset<-test$x[test_index,]
#作成したモデルを利用して10,13,17,21の画像の評価結果
predict(mnist.nnet.model,test_dataset,type="class")
#作成したモデルを利用して、テスト用データの画像データ(test$x)すべてを判別
mnist.result<-predict(mnist.nnet.model,test$x,type="class")
#判別した結果(mnist.result)とテスト用データの答え(test$y)を表形式で出力
table(test$y, mnist.result, dnn = c("actual","predicted"))

#課題1：kadai.one.modelの結果、kadai.one.trainを確認してモデルがどう間違っているか
kadai.one.result<-predict(kadai.one.model,test$x,type="class")
table(test$y, kadai.one.result, dnn = c("actual","predicted"))

#課題2：kadai.two.modelの結果、kadai.two.trainを確認してモデルがどう間違っているか
kadai.two.result<-predict(kadai.two.model,test$x,type="class")
table(test$y, kadai.two.result, dnn = c("actual","predicted"))

#課題3：kadai.three.modelの結果、kadai.three.trainを確認してモデルがどう間違っているか
kadai.three.result<-predict(kadai.three.model,test$x,type="class")
table(test$y, kadai.three.result, dnn = c("actual","predicted"))

#課題4：kadai.four.modelの結果、kadai.four.trainを確認してモデルがどう間違っているか
kadai.four.result<-predict(kadai.four.model,test$x,type="class")
table(test$y, kadai.four.result, dnn = c("actual","predicted"))

#課題5：kadai.five.testを確認して評価データがどう間違っているか
kadai.five.result<-predict(mnist.nnet.model,kadai.five.test$x,type="class")
table(kadai.five.test$y, kadai.five.result, dnn = c("actual","predicted"))

#課題6：kadai.six.testを確認して評価データがどう間違っているか
kadai.six.result<-predict(mnist.nnet.model,kadai.six.test$x,type="class")
table(kadai.six.test$y, kadai.six.result, dnn = c("actual","predicted"))
