books_key <- "&api-key=76363c9e70bc401bac1e6ad88b13bd1d"
url <- "http://api.nytimes.com/svc/books/v2/lists/overview.json?published_date=2013-01-01"
req <- fromJSON(paste0(url, books_key))
bestsellers <- req$results$list
category1 <- bestsellers[[1, "books"]]
subset(category1, select = c("author", "title", "publisher"))