# Sentiment-Analysis

## Introduction
The growing trend of digital streaming media has significantly transformed content consumption patterns and enjoyment among individuals. Technological advancements have provided users with unprecedented convenience and accessibility, enabling them to enjoy their preferred content at leisure and anywhere. Online media streaming has resulted in a notable revolution in the entertainment industry, enabling users to access various content, including films and TV shows, conveniently. One of the prominent streaming platforms, Netflix, has witnessed substantial popularity worldwide, catering to diverse interests with its wide range of audio-visual content.

## Objective
This analysis aims to gain a deeper understanding of Netflix user sentiment over time by analyzing 10,000 reviews from the Play Store until 2nd June 2023. The critical aspects studied include sentiment scores, emotion classification, and word frequency to assess user satisfaction and identify patterns.

## Methodology
### Data Collection and Preprocessing
The data was sourced from the Play Store on Kaggle and underwent preprocessing to ensure consistency and remove noise. Steps included converting text to lowercase, removing numbers and punctuations, and eliminating common English and custom stopwords.

### Sentiment Analysis using Lexicons
The sentiment of each review was analyzed using three lexicons: Syuzhet, Bing, and Afinn. The scores ranged from negative to positive, providing insights into the overall sentiment distribution and specific reviews with extreme sentiment scores.

### Emotion Classification
The NRC sentiment analysis classified each review into emotions such as anger, anticipation, disgust, fear, joy, sadness, surprise, and trust. Proportions of each emotion were visualized using a bar plot.

### Word Frequency Analysis
Common positive and negative words were identified using the Bing lexicon. The term-document matrix calculated the frequency of these words in the reviews. The top 10 positive and negative words were presented to understand prevalent sentiments.

### Word Cloud Analysis
A word cloud visually compared the frequency of positive and negative words in the reviews, using the word cloud package with colour differentiation.

## Results and Conclusion
The analysis provided valuable insights into user sentiment and emotions of Netflix reviews. The findings contribute to a deeper understanding of user satisfaction and the impact of policy changes on the platform. Netflix can use these insights to make informed decisions, enhance user experience, and maintain user trust.
