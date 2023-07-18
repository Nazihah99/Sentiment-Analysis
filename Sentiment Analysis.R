library(tm) # for text mining
library(SnowballC) # for text stemming
library(wordcloud) # word-cloud generator
library(RColorBrewer) # color palettes
library(syuzhet) # for sentiment analysis
library(ggplot2) # for plotting graphs

text = readLines("C:/Users/Lenovo/Downloads/review/Netflix.csv")
docs = Corpus(VectorSource(text))
toSpace = content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs = tm_map(docs, toSpace, "/")
docs = tm_map(docs, toSpace, "@")
docs = tm_map(docs, toSpace, "\\|")

#grid.setlocale("LC_ALL","C")
docs = tm_map(docs, content_transformer(tolower)) # Convert the text to lower case
docs = tm_map(docs, removeNumbers) # Remove numbers
docs = tm_map(docs, removeWords, stopwords("english")) # Remove english common stopwords
docs = tm_map(docs, removeWords, c("s", "company","team")) # Remove your own stop word # specify your stopwords as a character vector
docs = tm_map(docs, removePunctuation) # Remove punctuations
docs = tm_map(docs, stripWhitespace) # Eliminate extra white spaces
#docs = tm_map(docs, stemDocument) # Text stemming - which reduces words to their root form

# Build a term-document matrix
dtm = TermDocumentMatrix(docs)
dtm_m = as.matrix(dtm)

## Sentiment scores with lexicons
syuzhet_vector = get_sentiment(text, method="syuzhet")
head(syuzhet_vector)
summary(syuzhet_vector)
text[which.max(syuzhet_vector)]
text[which.min(syuzhet_vector)]

# bing
bing_vector = get_sentiment(text, method="bing")
head(bing_vector)
summary(bing_vector)
text[which.min(bing_vector)]
text[which.max(bing_vector)]

#afinn
afinn_vector = get_sentiment(text, method="afinn")
head(afinn_vector)
summary(afinn_vector)
text[which.min(afinn_vector)]
text[which.max(afinn_vector)]


## Emotion classification
# run nrc sentiment analysis to return data frame with each row classified as one of the following
# emotions, rather than a score : 
# anger, anticipation, disgust, fear, joy, sadness, surprise, trust 
# and if the sentiment is positive or negative
d=get_nrc_sentiment(text) # Take time so much sometimes 
# Filter text with trust == 1
trust_1_text = text[d$trust == 1]
head(trust_1_text)
#Visualization
td=data.frame(t(d)) #transpose
td_new = data.frame(rowSums(td)) #The function rowSums computes column sums across rows for each level of a grouping variable.
names(td_new)[1] = "count" #Transformation and cleaning
td_new = cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) = NULL
td_new2=td_new[1:8,]

# Classification  emotion 
bar_colors = c("cyan", "magenta", "purple", "blue", "seagreen", "yellow", "orange", "red")
# Generate the barplot with specified colors
barplot( sort(colSums(prop.table(d[, 1:8]))), horiz = TRUE, cex.names = 0.7, las = 1,
         main = "Emotions in Netflix App Reviews:\nEmotion Classification", xlab = "Proportional",
         col = bar_colors, xlim = c(0,0.25))
bar_values = sort(colSums(prop.table(d[, 1:8])))
# Calculate the center of each bar
bar_centers = barplot(bar_values, horiz = TRUE, plot = FALSE)
# Add the values inside each bar
text(bar_values, bar_centers, labels = paste0(round(bar_values, 3)*100, "%"), pos = 4, cex = 0.7)

library(tidytext)
library(dplyr)
# Common of positive and negative words
tidy_dtm = tidy(dtm)
names(tidy_dtm)= c("word", "document", "count")
positive_terms =get_sentiments("bing") %>%   filter(sentiment == "positive") 
names(positive_terms)= c("word", "sentiments")
pos=tidy_dtm %>% inner_join(positive_terms) %>%   count(word, sort = TRUE) %>% data.frame()
head(pos,10)
negative_terms =get_sentiments("bing") %>%   filter(sentiment == "negative") 
names(negative_terms)= c("word", "sentiments")
neg=tidy_dtm %>% inner_join(negative_terms) %>%   count(word, sort = TRUE) %>% data.frame()
head(neg,10)

# Wordcloud analysis - comparison
library(reshape2)
library(wordcloud)
bing=get_sentiments("bing")
tidy_dtm %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = c("#F8766D", "#00BFC4"),title.size = 6) #export image -- 1080 x 1920
