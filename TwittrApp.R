#  Install Requried Packages
installed.packages("dplyr")
installed.packages("SnowballC")
installed.packages("tm")
installed.packages("twitteR")
installed.packages("syuzhet")

# Load Requried Packages
library("dplyr")
library("SnowballC")
library("tm")
library("twitteR")
library("syuzhet")


# Authonitical keys
consumer_key <- 'cQ8RGsfhs;klghsl;ghaslkvXuxopX1'
consumer_secret <- 'TV3pyhdslhaflks;hgfslgx5YOgd3UFSW1Wka'
access_token <- '12518592asgaj;sjg;gjl;sajgl;sgj;shgkls2KuRyvZS'
access_secret <- '71zb2YMXVC1sgsag;sgnncncsgg;agygygalsgywPIGbLrT'

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)
tweets_rawData <- userTimeline("realDonaldTrump", n=800)

n.tweet <- length(tweets_rawData)

tweets_rawData <- twListToDF(tweets_rawData) 

head(tweets_rawData)

tweets <- tweets_rawData[1]
tweets <- gsub("http.*","",tweets$text)
tweets <- gsub("https.*","",tweets)
tweets <- gsub("#.*","",tweets)
tweets <- gsub("@.*","",tweets)
tweets <- tolower(tweets)

head(tweets)

word.df <- as.vector(tweets)
emotion.df <- get_nrc_sentiment(word.df)
emotion.df2 <- cbind(tweets, emotion.df) 

head(emotion.df2)

sent.value <- get_sentiment(word.df)
most.positive <- word.df[sent.value == max(sent.value)]
most.positive

most.negative <- word.df[sent.value <= min(sent.value)] 
most.negative 

# Segregating positive and negative tweets

positive.tweets <- word.df[sent.value > 0]
negative.tweets <- word.df[sent.value < 0]
neutral.tweets <- word.df[sent.value == 0]
head(positive.tweets)

# Category table (Positive, Passive, Negative)
category_senti <- ifelse(sent.value < 0, "Negative", ifelse(sent.value > 0, "Positive", "Neutral"))
head(category_senti)
category_table <-  as.data.frame(table(category_senti))

# Convert into dataframe
#tweets$text <- tweets$text
#tweets$text <- tweets_rawData$text
#tweets <- as.data.frame(tweets$text)

df1 <- data.frame(tweets)
df2 <- data.frame(category_senti)

tweets_cleanData <- df1[1]
tweets_cleanData$Category <- df2[1]

head(tweets_cleanData)










